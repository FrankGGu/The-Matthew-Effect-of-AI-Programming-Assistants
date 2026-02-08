class Solution:
    def findLargestAlmostMissingInteger(self, nums: List[int]) -> int:
        if not nums:
            return -1

        max_num = max(nums)
        num_set = set(nums)

        for num in range(max_num, 0, -1):
            if num not in num_set:
                return num

        return -1