class Solution:
    def oddEvenJumps(self, arr: List[int]) -> int:
        n = len(arr)
        sorted_arr = sorted((val, idx) for idx, val in enumerate(arr))
        next_odd = [0] * n
        next_even = [0] * n

        for i in range(n):
            val, idx = sorted_arr[i]
            if i < n - 1:
                next_odd[idx] = sorted_arr[i + 1][1]
            else:
                next_odd[idx] = -1

        for i in range(n - 1, -1, -1):
            val, idx = sorted_arr[i]
            if i > 0:
                next_even[idx] = sorted_arr[i - 1][1]
            else:
                next_even[idx] = -1

        odd = [False] * n
        even = [False] * n
        odd[-1] = True
        even[-1] = True

        for i in range(n - 2, -1, -1):
            if next_odd[i] != -1:
                odd[i] = even[next_odd[i]]
            if next_even[i] != -1:
                even[i] = odd[next_even[i]]

        return sum(odd)