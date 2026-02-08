class Solution:
    def numWays(self, s: str) -> int:
        n = len(s)
        total_ones = s.count('1')
        MOD = 10**9 + 7

        if total_ones % 3 != 0:
            return 0

        if total_ones == 0:
            return (n - 1) * (n - 2) // 2 % MOD

        target_ones = total_ones // 3

        ones_indices = [i for i, char in enumerate(s) if char == '1']

        ways1 = ones_indices[target_ones] - ones_indices[target_ones - 1]
        ways2 = ones_indices[2 * target_ones] - ones_indices[2 * target_ones - 1]

        return (ways1 * ways2) % MOD