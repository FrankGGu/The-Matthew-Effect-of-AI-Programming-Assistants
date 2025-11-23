class Solution:
    def oddEvenJumps(self, arr: List[int]) -> int:
        n = len(arr)
        if n == 0:
            return 0

        sorted_indices = sorted(range(n), key=lambda i: (arr[i], i))
        next_higher = self._get_next_jump_indices(sorted_indices)

        sorted_indices = sorted(range(n), key=lambda i: (-arr[i], i))
        next_lower = self._get_next_jump_indices(sorted_indices)

        odd = [False] * n
        even = [False] * n
        odd[-1] = even[-1] = True

        for i in range(n-2, -1, -1):
            if next_higher[i] is not None:
                odd[i] = even[next_higher[i]]
            if next_lower[i] is not None:
                even[i] = odd[next_lower[i]]

        return sum(odd)

    def _get_next_jump_indices(self, sorted_indices):
        stack = []
        next_jump = [None] * len(sorted_indices)
        for i in sorted_indices:
            while stack and stack[-1] < i:
                next_jump[stack.pop()] = i
            stack.append(i)
        return next_jump