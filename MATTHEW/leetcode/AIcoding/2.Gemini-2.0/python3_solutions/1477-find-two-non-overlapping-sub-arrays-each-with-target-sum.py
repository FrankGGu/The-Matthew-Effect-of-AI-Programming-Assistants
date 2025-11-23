class Solution:
    def minSumOfLengths(self, arr: list[int], target: int) -> int:
        n = len(arr)
        left = [-1] * n
        right = [-1] * n
        curr_sum = 0
        start = 0
        min_len = float('inf')
        for i in range(n):
            curr_sum += arr[i]
            while curr_sum > target:
                curr_sum -= arr[start]
                start += 1
            if curr_sum == target:
                length = i - start + 1
                min_len = min(min_len, length)
            left[i] = min_len
        curr_sum = 0
        start = n - 1
        min_len = float('inf')
        for i in range(n - 1, -1, -1):
            curr_sum += arr[i]
            while curr_sum > target:
                curr_sum -= arr[start]
                start -= 1
            if curr_sum == target:
                length = start - i + 1
                min_len = min(min_len, length)
            right[i] = min_len
        ans = float('inf')
        for i in range(n - 1):
            if left[i] != -1 and right[i + 1] != -1:
                ans = min(ans, left[i] + right[i + 1])
        if ans == float('inf'):
            return -1
        else:
            return ans