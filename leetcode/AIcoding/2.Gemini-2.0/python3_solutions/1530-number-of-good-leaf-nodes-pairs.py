class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        self.count = 0

        def dfs(node):
            if not node:
                return []
            if not node.left and not node.right:
                return [1]

            left_leaves = dfs(node.left)
            right_leaves = dfs(node.right)

            for l_dist in left_leaves:
                for r_dist in right_leaves:
                    if l_dist + r_dist <= distance:
                        self.count += 1

            result = []
            for l_dist in left_leaves:
                if l_dist + 1 <= distance:
                    result.append(l_dist + 1)
            for r_dist in right_leaves:
                if r_dist + 1 <= distance:
                    result.append(r_dist + 1)
            return result

        dfs(root)
        return self.count