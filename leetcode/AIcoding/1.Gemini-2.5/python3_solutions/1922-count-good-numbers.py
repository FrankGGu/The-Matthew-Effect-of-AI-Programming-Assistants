class Solution:
    def countGoodNumbers(self, n: int) -> int:
        MOD = 10**9 + 7

        num_even_positions = (n + 1) // 2
        num_odd_positions = n // 2

        # For even positions (0-indexed: 0, 2, 4, ...), digits can be 0, 2, 4, 6, 8 (5 choices)
        # For odd positions (0-indexed: 1, 3, 5, ...), digits can be 2, 3, 5, 7 (4 choices)

        count_for_even_positions = pow(5, num_even_positions, MOD)
        count_for_odd_positions = pow(4, num_odd_positions, MOD)

        return (count_for_even_positions * count_for_odd_positions) % MOD