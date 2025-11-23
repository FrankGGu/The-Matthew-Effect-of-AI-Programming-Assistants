class Solution:
    def productQueries(self, n: int, queries: list[list[int]]) -> list[int]:
        MOD = 10**9 + 7

        powers = []
        i = 0
        temp_n = n
        while temp_n > 0:
            if temp_n & 1:
                powers.append(1 << i)
            temp_n >>= 1
            i += 1

        prefix_products = [0] * len(powers)
        if len(powers) > 0:
            prefix_products[0] = powers[0] % MOD
            for k in range(1, len(powers)):
                prefix_products[k] = (prefix_products[k-1] * powers[k]) % MOD

        results = []
        for left, right in queries:
            current_product = prefix_products[right]
            if left > 0:
                inverse_val = pow(prefix_products[left-1], MOD - 2, MOD)
                current_product = (current_product * inverse_val) % MOD
            results.append(current_product)

        return results