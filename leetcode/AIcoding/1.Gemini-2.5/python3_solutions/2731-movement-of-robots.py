class Solution:
    def sumDistance(self, nums: list[int], s: str, d: int) -> int:
        n = len(nums)
        MOD = 10**9 + 7

        final_positions = []
        for i in range(n):
            if s[i] == 'L':
                final_positions.append(nums[i] - d)
            else:  # s[i] == 'R'
                final_positions.append(nums[i] + d)

        final_positions.sort()

        total_sum = 0
        # The sum required is sum(abs(final_positions[j] - final_positions[i])) for 0 <= i < j < n.
        # After sorting, abs(final_positions[j] - final_positions[i]) becomes final_positions[j] - final_positions[i].
        # The total sum can be efficiently calculated as sum(final_positions[k] * (2*k - (n-1))) for k in range(n).
        for k in range(n):
            coefficient = 2 * k - (n - 1)
            term = final_positions[k] * coefficient
            total_sum = (total_sum + term) % MOD

        return total_sum