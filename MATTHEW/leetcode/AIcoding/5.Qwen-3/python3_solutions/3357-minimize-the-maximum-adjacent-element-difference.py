class Solution:
    def oddEvenJumps(self, arr: List[int]) -> int:
        n = len(arr)
        sorted_arr = sorted((val, idx) for idx, val in enumerate(arr))
        next_higher = [0] * n
        next_lower = [0] * n

        for i in range(n):
            val, idx = sorted_arr[i]
            while i + 1 < n and sorted_arr[i + 1][0] == val:
                i += 1
            if i + 1 < n:
                next_higher[idx] = sorted_arr[i + 1][1]
            else:
                next_higher[idx] = -1

        for i in range(n - 1, -1, -1):
            val, idx = sorted_arr[i]
            while i - 1 >= 0 and sorted_arr[i - 1][0] == val:
                i -= 1
            if i - 1 >= 0:
                next_lower[idx] = sorted_arr[i - 1][1]
            else:
                next_lower[idx] = -1

        even = [False] * n
        odd = [False] * n
        even[n - 1] = True
        odd[n - 1] = True

        for i in range(n - 2, -1, -1):
            if next_higher[i] != -1:
                even[i] = odd[next_higher[i]]
            if next_lower[i] != -1:
                odd[i] = even[next_lower[i]]

        return sum(odd)