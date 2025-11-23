class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        n = len(arr)
        if n == 1:
            return arr[0]

        left_no_delete = [0] * n
        left_no_delete[0] = arr[0]
        for i in range(1, n):
            left_no_delete[i] = max(arr[i], left_no_delete[i-1] + arr[i])

        right_no_delete = [0] * n
        right_no_delete[-1] = arr[-1]
        for i in range(n-2, -1, -1):
            right_no_delete[i] = max(arr[i], right_no_delete[i+1] + arr[i])

        max_sum = max(left_no_delete)

        for i in range(1, n-1):
            max_sum = max(max_sum, left_no_delete[i-1] + right_no_delete[i+1])

        return max_sum