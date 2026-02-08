class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findTarget(self, root: TreeNode, k: int) -> bool:
        nums = set()
        return self.traverse(root, k, nums)

    def traverse(self, node: TreeNode, k: int, nums: set) -> bool:
        if not node:
            return False
        if k - node.val in nums:
            return True
        nums.add(node.val)
        return self.traverse(node.left, k, nums) or self.traverse(node.right, k, nums)