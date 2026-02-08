from collections import defaultdict, deque

class Solution:
    def verticalTraversal(self, root: TreeNode) -> List[List[int]]:
        nodes = []

        def dfs(node, x, y):
            if node:
                nodes.append((x, y, node.val))
                dfs(node.left, x - 1, y + 1)
                dfs(node.right, x + 1, y + 1)

        dfs(root, 0, 0)
        nodes.sort()
        result = defaultdict(list)

        for x, y, value in nodes:
            result[x].append(value)

        return [result[x] for x in sorted(result)]