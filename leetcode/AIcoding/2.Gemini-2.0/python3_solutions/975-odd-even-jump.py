class Solution:
    def oddEvenJumps(self, arr: List[int]) -> int:
        n = len(arr)
        next_higher = [0] * n
        next_lower = [0] * n

        stack = []
        for i in range(n - 1, -1, -1):
            while stack and arr[stack[-1]] < arr[i]:
                stack.pop()
            if stack:
                next_higher[i] = stack[-1]
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            while stack and arr[stack[-1]] > arr[i]:
                stack.pop()
            if stack:
                next_lower[i] = stack[-1]
            stack.append(i)

        higher = [False] * n
        lower = [False] * n
        higher[-1] = lower[-1] = True

        for i in range(n - 2, -1, -1):
            if next_higher[i] != 0:
                higher[i] = lower[next_higher[i]]
            if next_lower[i] != 0:
                lower[i] = higher[next_lower[i]]

        return sum(higher)