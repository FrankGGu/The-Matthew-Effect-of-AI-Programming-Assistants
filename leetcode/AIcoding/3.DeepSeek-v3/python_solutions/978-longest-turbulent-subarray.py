class Solution:
    def maxTurbulenceSize(self, arr: List[int]) -> int:
        n = len(arr)
        if n == 1:
            return 1
        res = 1
        prev_diff = 0
        current = 1

        for i in range(1, n):
            diff = arr[i] - arr[i-1]
            if (diff > 0 and prev_diff <= 0) or (diff < 0 and prev_diff >= 0):
                current += 1
                res = max(res, current)
            else:
                current = 2 if diff != 0 else 1
            prev_diff = diff

        return res