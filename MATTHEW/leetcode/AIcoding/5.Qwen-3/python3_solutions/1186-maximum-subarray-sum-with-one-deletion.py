class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        n = len(arr)
        if n == 0:
            return 0
        if n == 1:
            return arr[0]

        delete = arr[0]
        no_delete = arr[0]
        max_sum = arr[0]

        for i in range(1, n):
            new_delete = max(delete + arr[i], no_delete + arr[i])
            new_no_delete = max(no_delete + arr[i], arr[i])
            delete, no_delete = new_delete, new_no_delete
            max_sum = max(max_sum, delete, no_delete)

        return max_sum