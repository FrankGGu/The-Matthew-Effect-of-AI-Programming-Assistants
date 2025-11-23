class Solution:
    def sumSubarrayMins(self, arr: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(arr)
        left = [0] * n
        right = [0] * n

        stack = []
        for i in range(n):
            count = 1
            while stack and arr[stack[-1]] > arr[i]:
                count += left[stack.pop()]
            left[i] = count
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            count = 1
            while stack and arr[stack[-1]] >= arr[i]:
                count += right[stack.pop()]
            right[i] = count
            stack.append(i)

        result = 0
        for i in range(n):
            result = (result + arr[i] * left[i] * right[i]) % MOD

        return result