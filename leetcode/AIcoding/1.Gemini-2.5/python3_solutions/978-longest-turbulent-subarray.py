class Solution:
    def maxTurbulenceSize(self, arr: list[int]) -> int:
        n = len(arr)
        if n <= 1:
            return n

        max_len = 1
        inc = 1
        dec = 1

        for i in range(1, n):
            if arr[i-1] < arr[i]:
                inc = dec + 1
                dec = 1
            elif arr[i-1] > arr[i]:
                dec = inc + 1
                inc = 1
            else:
                inc = 1
                dec = 1
            max_len = max(max_len, inc, dec)

        return max_len