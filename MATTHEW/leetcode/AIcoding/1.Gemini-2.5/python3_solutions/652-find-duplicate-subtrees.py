import collections

class Solution:
    def findDuplicateSubtrees(self, root: Optional[TreeNode]) -> List[Optional[TreeNode]]:
        counts = collections.Counter()
        res = []

        def dfs(node):
            if not node:
                return "#"

            left_s = dfs(node.left)
            right_s = dfs(node.right)

            s = f"{left_s},{node.val},{right_s}"

            counts[s] += 1
            if counts[s] == 2:
                res.append(node)

            return s

        dfs(root)
        return res