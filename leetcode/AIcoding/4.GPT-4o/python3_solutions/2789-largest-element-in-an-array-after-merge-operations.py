class Solution:
    def findLargestNumAfterMergeOperations(self, nums: List[int], maxOperations: int) -> int:
        left, right = 1, max(nums)

        while left < right:
            mid = (left + right) // 2
            operations = sum((num - 1) // mid for num in nums)

            if operations > maxOperations:
                left = mid + 1
            else:
                right = mid

        return left