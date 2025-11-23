class Solution:
    def getMaximumGenerated(self, nums: int) -> int:
        if nums == 0:
            return 0
        if nums == 1:
            return 1
        arr = [0] * nums
        arr[0] = 0
        arr[1] = 1
        max_val = 1
        for i in range(2, nums):
            if i % 2 == 0:
                arr[i] = arr[i // 2]
            else:
                arr[i] = arr[i // 2] + arr[i // 2 + 1]
            if arr[i] > max_val:
                max_val = arr[i]
        return max_val