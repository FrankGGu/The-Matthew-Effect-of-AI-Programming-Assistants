from collections import Counter

class Solution:
    def countKSubsequencesWithMaxBeauty(self, s: str, k: int) -> int:
        MOD = 10**9 + 7
        freq = Counter(s)
        if len(freq) < k:
            return 0

        freq_values = sorted(freq.values(), reverse=True)
        target = freq_values[k-1]

        total = 1
        count_target = 0
        chosen = 0

        for val in freq_values:
            if val > target:
                total = (total * val) % MOD
                chosen += 1
            elif val == target:
                count_target += 1

        remaining = k - chosen
        if remaining <= 0:
            return total % MOD

        # Compute combination(count_target, remaining) * (target^remaining) % MOD
        comb = 1
        for i in range(remaining):
            comb = comb * (count_target - i) % MOD
            comb = comb * pow(i + 1, MOD - 2, MOD) % MOD

        power = pow(target, remaining, MOD)
        total = total * comb % MOD
        total = total * power % MOD

        return total