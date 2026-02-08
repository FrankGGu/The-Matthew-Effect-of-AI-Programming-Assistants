class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        n = len(arr)
        max_sum = arr[0]
        max_end_here = arr[0]
        max_end_here_with_del = 0

        for i in range(1, n):
            max_end_here = max(arr[i], max_end_here + arr[i])
            max_end_here_with_del = max(max_end_here_with_del + arr[i], max_end_here)
            max_sum = max(max_sum, max_end_here, max_end_here_with_del)

        return max_sum