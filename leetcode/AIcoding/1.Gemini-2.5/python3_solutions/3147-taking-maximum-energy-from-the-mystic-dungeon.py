class Solution:
    def maximumEnergy(self, energy: list[int], k: int) -> int:
        n = len(energy)

        dp = [0] * n

        for i in range(n - 1, -1, -1):
            current_energy = energy[i]

            if i + k < n:
                dp[i] = current_energy + dp[i + k]
            else:
                dp[i] = current_energy

        return max(dp)