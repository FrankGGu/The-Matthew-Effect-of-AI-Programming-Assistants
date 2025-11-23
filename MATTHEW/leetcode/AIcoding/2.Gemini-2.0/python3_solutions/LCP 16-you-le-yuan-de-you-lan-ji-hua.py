class Solution:
    def maxTotalImbalance(self, nums: list[int]) -> int:
        n = len(nums)
        total_imbalance = 0

        for i in range(n):
            for j in range(i + 1, n):
                sub_array = nums[i:j + 1]
                sub_array.sort()
                imbalance = 0
                for k in range(1, len(sub_array)):
                    diff = sub_array[k] - sub_array[k - 1]
                    if diff > 1:
                        imbalance += diff - 1
                total_imbalance += imbalance

        return total_imbalance