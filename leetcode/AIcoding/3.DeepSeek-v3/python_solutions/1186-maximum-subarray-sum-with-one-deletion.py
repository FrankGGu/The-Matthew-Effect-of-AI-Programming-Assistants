class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        n = len(arr)
        if n == 1:
            return arr[0]

        no_delete = [0] * n
        delete = [0] * n

        no_delete[0] = arr[0]
        delete[0] = -float('inf')

        max_sum = arr[0]

        for i in range(1, n):
            no_delete[i] = max(arr[i], no_delete[i-1] + arr[i])
            delete[i] = max(no_delete[i-1], delete[i-1] + arr[i])
            current_max = max(no_delete[i], delete[i])
            if current_max > max_sum:
                max_sum = current_max

        return max_sum