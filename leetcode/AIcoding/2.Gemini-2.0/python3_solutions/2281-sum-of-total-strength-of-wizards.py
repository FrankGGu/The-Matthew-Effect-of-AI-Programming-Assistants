class Solution:
    def sumOfTotalStrength(self, strength: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(strength)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = (prefix_sum[i] + strength[i]) % MOD

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
        for i in range(n - 1, -1, -1):
            while stack and strength[stack[-1]] > strength[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            stack.append(i)

        ans = 0
        for i in range(n):
            l = left[i]
            r = right[i]

            left_len = i - l
            right_len = r - i

            left_sum = (i - l) * (prefix_sum[i] - prefix_sum[l]) - self.sum_of_arithmetic_progression(l, i - 1, strength, prefix_sum, MOD)
            left_sum %= MOD

            right_sum = self.sum_of_arithmetic_progression(i + 1, r - 1, strength, prefix_sum, MOD) - (r - i) * (prefix_sum[i+1] - prefix_sum[i])
            right_sum %= MOD

            total_sum = (left_len * right_sum + right_len * left_sum + left_len * right_len * strength[i]) % MOD

            ans = (ans + strength[i] * total_sum) % MOD

        return ans

    def sum_of_arithmetic_progression(self, start, end, strength, prefix_sum, MOD):
        if start > end:
            return 0

        sum_val = 0
        curr_sum = prefix_sum[end + 1] - prefix_sum[start]

        sum_val = (end - start + 1) * prefix_sum[start] - self.sum_of_arithmetic_progression_helper(start, end, strength, MOD)

        return sum_val % MOD

    def sum_of_arithmetic_progression_helper(self, start, end, strength, MOD):
        pref_sum_sum = 0
        sum_sum = 0
        for i in range(start, end + 1):
            sum_sum = (sum_sum + i * strength[i]) % MOD
        return sum_sum % MOD