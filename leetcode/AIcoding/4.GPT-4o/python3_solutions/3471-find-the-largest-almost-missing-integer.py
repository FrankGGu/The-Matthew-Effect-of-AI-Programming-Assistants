class Solution:
    def findLargestMissing(self, nums: List[int]) -> int:
        num_set = set(nums)
        max_num = max(nums)

        for i in range(max_num, -1, -1):
            if i not in num_set:
                return i
        return -1