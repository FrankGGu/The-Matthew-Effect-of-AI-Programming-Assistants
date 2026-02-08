class Solution:
    def maxNonOverlapping(self, nums: list[int], target: int) -> int:
        count = 0
        current_sum = 0
        seen_sums = {0}

        for num in nums:
            current_sum += num
            if (current_sum - target) in seen_sums:
                count += 1
                current_sum = 0
                seen_sums = {0}
            else:
                seen_sums.add(current_sum)

        return count