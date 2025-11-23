import collections

class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, k: int) -> list[int]:
        graph = collections.defaultdict(list)

        def build_graph(node, parent):
            if node:
                if parent:
                    graph[node.val].append(parent.val)
                    graph[parent.val].append(node.val)
                build_graph(node.left, node)
                build_graph(node.right, node)

        build_graph(root, None)

        queue = collections.deque([(target.val, 0)])
        visited = {target.val}
        result = []

        while queue:
            node, dist = queue.popleft()
            if dist == k:
                result.append(node)
            elif dist < k:
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append((neighbor, dist + 1))

        return result