class Solution:
    def totalStrength(self, strength: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(strength)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = (prefix_sum[i] + strength[i]) % MOD

        left = [0] * n
        right = [0] * n
        stack = []

        for i in range(n):
            while stack and strength[stack[-1]] >= strength[i]:
                stack.pop()
            left[i] = stack[-1] if stack else -1
            stack.append(i)

        stack.clear()

        for i in range(n - 1, -1, -1):
            while stack and strength[stack[-1]] > strength[i]:
                stack.pop()
            right[i] = stack[-1] if stack else n
            stack.append(i)

        total_strength = 0
        for i in range(n):
            total_strength += strength[i] * (prefix_sum[right[i]] - prefix_sum[left[i] + 1]) % MOD
            total_strength %= MOD

        return total_strength