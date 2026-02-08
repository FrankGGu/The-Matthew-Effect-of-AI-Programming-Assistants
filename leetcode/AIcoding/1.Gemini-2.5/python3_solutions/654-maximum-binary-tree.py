class Solution:
    def constructMaximumBinaryTree(self, nums: List[int]) -> Optional[TreeNode]:

        def _construct(left: int, right: int) -> Optional[TreeNode]:
            if left >= right:
                return None

            max_val = -1
            max_idx = -1
            for i in range(left, right):
                if nums[i] > max_val:
                    max_val = nums[i]
                    max_idx = i

            root = TreeNode(nums[max_idx])
            root.left = _construct(left, max_idx)
            root.right = _construct(max_idx + 1, right)

            return root

        return _construct(0, len(nums))