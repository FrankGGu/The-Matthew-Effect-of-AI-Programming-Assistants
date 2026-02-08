class Solution:
    def getNumber(self, root: TreeNode, ops: List[List[int]]) -> int:
        nodes = set()
        def dfs(node, start, end, color):
            if not node:
                return
            if start <= node.val <= end:
                if start <= node.val < end:
                    dfs(node.left, start, node.val - 1, color)
                if start < node.val <= end:
                    dfs(node.right, node.val + 1, end, color)
                if color == 1:
                    nodes.add(node.val)

        for op in ops[::-1]:
            dfs(root, op[1], op[2], op[0])
        return len(nodes)