class Solution:
    def maxNonOverlapping(self, nums: List[int], target: int) -> int:
        count = 0
        curr_sum = 0
        seen = {0}
        for num in nums:
            curr_sum += num
            if curr_sum - target in seen:
                count += 1
                curr_sum = 0
                seen = {0}
            else:
                seen.add(curr_sum)
        return count