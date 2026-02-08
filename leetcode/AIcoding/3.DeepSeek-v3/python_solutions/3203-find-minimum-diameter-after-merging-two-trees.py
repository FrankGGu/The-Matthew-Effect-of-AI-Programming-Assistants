import sys
from collections import deque

class Solution:
    def findMinimumDiameter(self, tree1: List[List[int]], tree2: List[List[int]]) -> int:
        def build_tree(edges):
            tree = {}
            for u, v in edges:
                if u not in tree:
                    tree[u] = []
                if v not in tree:
                    tree[v] = []
                tree[u].append(v)
                tree[v].append(u)
            return tree

        def get_farthest_node(tree, start):
            visited = {}
            q = deque([(start, 0)])
            farthest_node = start
            max_dist = 0
            visited[start] = True
            while q:
                node, dist = q.popleft()
                if dist > max_dist:
                    max_dist = dist
                    farthest_node = node
                for neighbor in tree.get(node, []):
                    if neighbor not in visited:
                        visited[neighbor] = True
                        q.append((neighbor, dist + 1))
            return farthest_node, max_dist

        def get_diameter(tree):
            if not tree:
                return 0
            node = next(iter(tree.keys()))
            u, _ = get_farthest_node(tree, node)
            v, diameter = get_farthest_node(tree, u)
            return diameter

        tree1_adj = build_tree(tree1)
        tree2_adj = build_tree(tree2)

        if not tree1_adj and not tree2_adj:
            return 0
        if not tree1_adj:
            return get_diameter(tree2_adj)
        if not tree2_adj:
            return get_diameter(tree1_adj)

        def get_centers(tree):
            if not tree:
                return []
            node = next(iter(tree.keys()))
            u, _ = get_farthest_node(tree, node)
            v, diameter = get_farthest_node(tree, u)
            path = []
            visited = {}

            def dfs(node, target, parent, current_path):
                nonlocal path
                if node == target:
                    path = current_path.copy()
                    return True
                for neighbor in tree.get(node, []):
                    if neighbor != parent:
                        current_path.append(neighbor)
                        if dfs(neighbor, target, node, current_path):
                            return True
                        current_path.pop()
                return False

            dfs(u, v, -1, [u])
            if diameter % 2 == 0:
                return [path[diameter // 2]]
            else:
                return [path[diameter // 2], path[diameter // 2 + 1]

        centers1 = get_centers(tree1_adj)
        centers2 = get_centers(tree2_adj)

        min_diameter = sys.maxsize

        for c1 in centers1:
            for c2 in centers2:
                new_tree = {}
                for node in tree1_adj:
                    new_tree[node] = tree1_adj[node].copy()
                for node in tree2_adj:
                    if node in new_tree:
                        new_tree[node].extend(tree2_adj[node])
                    else:
                        new_tree[node] = tree2_adj[node].copy()
                new_tree[c1].append(c2)
                new_tree[c2].append(c1)
                diameter = get_diameter(new_tree)
                if diameter < min_diameter:
                    min_diameter = diameter

        return min_diameter