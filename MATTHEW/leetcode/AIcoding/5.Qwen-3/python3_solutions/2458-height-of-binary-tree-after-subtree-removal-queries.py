class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeQueries(self, root: TreeNode, queries: List[int]) -> List[int]:
        from collections import defaultdict, deque

        def get_height(node):
            if not node:
                return 0
            return 1 + max(get_height(node.left), get_height(node.right))

        height = {}
        def dfs(node):
            if not node:
                return 0
            h = 1 + max(dfs(node.left), dfs(node.right))
            height[node.val] = h
            return h

        dfs(root)

        level_map = defaultdict(list)
        def bfs(node):
            q = deque()
            q.append((node, 0))
            while q:
                node, level = q.popleft()
                level_map[level].append(node.val)
                if node.left:
                    q.append((node.left, level + 1))
                if node.right:
                    q.append((node.right, level + 1))

        bfs(root)

        level_dict = {}
        for level in level_map:
            nodes = level_map[level]
            sorted_nodes = sorted(nodes, key=lambda x: -height[x])
            level_dict[level] = sorted_nodes

        result = []
        for q in queries:
            for level in level_dict:
                nodes = level_dict[level]
                if q in nodes:
                    if len(nodes) == 1:
                        new_height = 0
                    else:
                        new_height = max(height[nodes[0]], height[nodes[1]]) if len(nodes) >= 2 else 0
                    result.append(new_height - 1)
                    break
            else:
                result.append(0)

        return result