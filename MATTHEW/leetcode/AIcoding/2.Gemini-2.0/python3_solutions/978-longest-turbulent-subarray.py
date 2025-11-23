class Solution:
    def maxTurbulenceSize(self, arr: list[int]) -> int:
        n = len(arr)
        if n < 2:
            return n

        max_len = 1
        l = 0

        for i in range(1, n):
            if i == 1:
                if arr[i] != arr[i-1]:
                    max_len = 2
                    l = 0
                else:
                    l = 1

            else:
                if (arr[i] > arr[i-1] and arr[i-1] < arr[i-2]) or (arr[i] < arr[i-1] and arr[i-1] > arr[i-2]):
                    max_len = max(max_len, i - l + 1)
                else:
                    if arr[i] != arr[i-1]:
                        l = i - 1
                        max_len = max(max_len, 2)
                    else:
                        l = i

        return max_len