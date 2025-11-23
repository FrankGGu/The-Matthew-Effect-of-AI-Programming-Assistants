class Solution:
    def totalStrength(self, strength: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(strength)

        left = [ -1 ] * n
        right = [ n ] * n
        stack = []

        for i in range(n):
            while stack and strength[stack[-1]] <= strength[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1]
            else:
                left[i] = -1
            stack.append(i)

        stack = []
        for i in range(n-1, -1, -1):
            while stack and strength[stack[-1]] < strength[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            else:
                right[i] = n
            stack.append(i)

        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = (prefix[i] + strength[i]) % MOD

        prefix2 = [0] * (n + 1)
        for i in range(n):
            prefix2[i+1] = (prefix2[i] + prefix[i+1]) % MOD

        res = 0
        for i in range(n):
            l = left[i]
            r = right[i]
            cnt = (i - l) * (r - i)
            sum_l = prefix[i] - prefix[l + 1]
            sum_r = prefix[r] - prefix[i + 1]
            sum_total = (sum_l * (r - i) + sum_r * (i - l)) % MOD
            res = (res + strength[i] * sum_total) % MOD

        return res