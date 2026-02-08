class Solution:
    def maximumEnergy(self, energy: List[int], k: int) -> int:
        n = len(energy)
        max_energy = -float('inf')

        for i in range(n - 1, n - k - 1, -1):
            current_sum = 0
            for j in range(i, -1, -k):
                current_sum += energy[j]
                if current_sum > max_energy:
                    max_energy = current_sum

        return max_energy