class Solution:
    def sumImbalanceNumbers(self, nums: List[int]) -> int:
        n = len(nums)
        total_imbalance = 0
        for i in range(n):
            for j in range(i, n):
                sub_array = nums[i:j+1]
                sub_array.sort()
                imbalance = 0
                for k in range(1, len(sub_array)):
                    if sub_array[k] - sub_array[k-1] > 1:
                        imbalance += 1
                total_imbalance += imbalance
        return total_imbalance