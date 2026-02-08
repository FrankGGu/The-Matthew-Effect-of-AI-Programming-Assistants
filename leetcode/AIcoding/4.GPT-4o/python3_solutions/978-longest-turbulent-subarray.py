class Solution:
    def maxTurbulenceSize(self, arr: List[int]) -> int:
        n = len(arr)
        if n < 2:
            return n

        max_len = 1
        current_len = 1

        for i in range(1, n):
            if arr[i] > arr[i - 1]:
                if i == 1 or arr[i - 1] <= arr[i - 2]:
                    current_len = 2
                else:
                    current_len += 1
            elif arr[i] < arr[i - 1]:
                if i == 1 or arr[i - 1] >= arr[i - 2]:
                    current_len = 2
                else:
                    current_len += 1
            else:
                current_len = 1

            max_len = max(max_len, current_len)

        return max_len