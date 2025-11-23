class Solution:
    def countGoodSubarrays(self, arr: list[int], k: int) -> int:
        count = 0
        for i in range(len(arr) - 2):
            if abs(arr[i] - arr[i+1]) <= k and abs(arr[i+1] - arr[i+2]) <= k and abs(arr[i] - arr[i+2]) <= k:
                count += 1
        return count