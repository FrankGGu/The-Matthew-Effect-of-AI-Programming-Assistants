class Solution:
    def numSubarrayBoundedMax(self, nums: List[int], left: int, right: int) -> int:
        count = 0
        start = -1
        last_valid = -1
        for i, num in enumerate(nums):
            if left <= num <= right:
                last_valid = i
                count += (i - start)
            elif num < left:
                if last_valid != -1:
                    count += (last_valid - start)
            else:
                start = i
                last_valid = -1
        return count