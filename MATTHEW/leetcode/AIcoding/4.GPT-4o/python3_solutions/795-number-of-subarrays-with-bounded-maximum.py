class Solution:
    def numSubarrayBoundedMax(self, nums: List[int], left: int, right: int) -> int:
        def count(bound):
            count, result = 0, 0
            for num in nums:
                if num <= bound:
                    count += 1
                    result += count
                else:
                    count = 0
            return result

        return count(right) - count(left - 1)