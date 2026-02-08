class Solution:
    def numberOfSequence(self, n: int, infected: list[int]) -> int:
        MOD = 10**9 + 7

        def power(base, exp):
            res = 1
            base %= MOD
            while exp > 0:
                if exp % 2 == 1:
                    res = (res * base) % MOD
                base = (base * base) % MOD
                exp //= 2
            return res

        def modInverse(n_val):
            return power(n_val, MOD - 2)

        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)
        for i in range(1, n + 1):
            fact[i] = (fact[i-1] * i) % MOD

        inv_fact[n] = modInverse(fact[n])
        for i in range(n - 1, -1, -1):
            inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD

        infected.sort()

        k = len(infected)
        total_uninfected = n - k

        if total_uninfected == 0:
            return 1

        ans = fact[total_uninfected]

        left_len = infected[0]
        ans = (ans * inv_fact[left_len]) % MOD

        right_len = n - 1 - infected[-1]
        ans = (ans * inv_fact[right_len]) % MOD

        for i in range(1, k):
            mid_len = infected[i] - infected[i-1] - 1
            if mid_len > 0:
                ans = (ans * inv_fact[mid_len]) % MOD
                ans = (ans * power(2, mid_len - 1)) % MOD

        return ans