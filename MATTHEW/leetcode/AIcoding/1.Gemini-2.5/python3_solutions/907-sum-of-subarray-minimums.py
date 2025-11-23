class Solution:
    def sumSubarrayMins(self, arr: list[int]) -> int:
        MOD = 10**9 + 7
        n = len(arr)

        ple = [-1] * n
        stack = []
        for i in range(n):
            while stack and arr[stack[-1]] > arr[i]:
                stack.pop()
            if stack:
                ple[i] = stack[-1]
            stack.append(i)

        nsl = [n] * n
        stack = []
        for i in range(n - 1, -1, -1):
            while stack and arr[stack[-1]] >= arr[i]:
                stack.pop()
            if stack:
                nsl[i] = stack[-1]
            stack.append(i)

        total_sum = 0
        for i in range(n):
            left_count = i - ple[i]
            right_count = nsl[i] - i

            contribution = (arr[i] * left_count * right_count) % MOD
            total_sum = (total_sum + contribution) % MOD

        return total_sum