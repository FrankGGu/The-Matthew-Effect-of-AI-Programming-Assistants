class Solution:
    def getMinimumDifference(self, root: TreeNode) -> int:
        def inorder(node):
            if not node:
                return []
            return inorder(node.left) + [node.val] + inorder(node.right)

        nums = inorder(root)
        min_diff = float('inf')
        for i in range(1, len(nums)):
            min_diff = min(min_diff, nums[i] - nums[i-1])
        return min_diff