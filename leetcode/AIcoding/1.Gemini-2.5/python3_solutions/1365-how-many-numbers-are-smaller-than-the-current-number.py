class Solution:
    def smallerNumbersThanCurrent(self, nums: list[int]) -> list[int]:
        counts = [0] * 101  # Max value for nums[i] is 100
        for num in nums:
            counts[num] += 1

        smaller_counts = [0] * 101
        for i in range(1, 101):
            smaller_counts[i] = smaller_counts[i-1] + counts[i-1]

        result = []
        for num in nums:
            result.append(smaller_counts[num])

        return result