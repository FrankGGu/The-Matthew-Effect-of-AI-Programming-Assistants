class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findTarget(self, root: TreeNode, k: int) -> bool:
        nums = []
        def inorder(node):
            if not node:
                return
            inorder(node.left)
            nums.append(node.val)
            inorder(node.right)

        inorder(root)

        left, right = 0, len(nums) - 1
        while left < right:
            curr_sum = nums[left] + nums[right]
            if curr_sum == k:
                return True
            elif curr_sum < k:
                left += 1
            else:
                right -= 1

        return False