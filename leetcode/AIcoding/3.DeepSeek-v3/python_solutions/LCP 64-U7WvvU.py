class Solution:
    def closeLampInTree(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return (0, 0, 0, 0)
            left = dfs(node.left)
            right = dfs(node.right)

            # state 0: all off
            s0 = left[0] + right[0] + (0 if node.val == 0 else 1)

            # state 1: all on
            s1 = left[1] + right[1] + (0 if node.val == 1 else 1)

            # state 2: node and its children are toggled
            s2 = left[3] + right[3] + (0 if node.val == 1 else 1)

            # state 3: children are toggled
            s3 = left[2] + right[2] + (0 if node.val == 0 else 1)

            return (min(s0, s2 + 2, s1 + 2, s3 + 2), 
                    min(s1, s3 + 2, s0 + 2, s2 + 2), 
                    min(s2, s0 + 2, s1 + 2, s3 + 2), 
                    min(s3, s1 + 2, s0 + 2, s2 + 2))

        res = dfs(root)
        return min(res[0], res[1] + 1, res[2] + 1, res[3] + 2)