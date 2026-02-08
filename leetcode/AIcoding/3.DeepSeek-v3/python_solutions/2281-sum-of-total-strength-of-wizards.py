class Solution:
    def totalStrength(self, strength: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(strength)

        left = [-1] * n
        stack = []
        for i in range(n):
            while stack and strength[stack[-1]] >= strength[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1]
            stack.append(i)

        right = [n] * n
        stack = []
        for i in range(n-1, -1, -1):
            while stack and strength[stack[-1]] > strength[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            stack.append(i)

        prefix = [0] * (n + 2)
        for i in range(n):
            prefix[i+1] = (prefix[i] + strength[i]) % MOD

        prefix_prefix = [0] * (n + 2)
        for i in range(n):
            prefix_prefix[i+1] = (prefix_prefix[i] + prefix[i+1]) % MOD

        res = 0
        for i in range(n):
            l = left[i] + 1
            r = right[i] - 1
            total = (prefix_prefix[r+1] - prefix_prefix[i+1]) * (i - l + 1) % MOD
            total -= (prefix_prefix[i+1] - prefix_prefix[l]) * (r - i + 1) % MOD
            total = total * strength[i] % MOD
            res = (res + total) % MOD
        return res