class Solution:
    def minNumberOfHours(self, initialEnergy: int, initialExperience: int, energy: List[int], experience: List[int]) -> int:
        required_energy = sum(energy) + 1
        energy_hours = max(0, required_energy - initialEnergy)

        exp_hours = 0
        current_exp = initialExperience
        for exp in experience:
            if current_exp <= exp:
                needed = exp - current_exp + 1
                exp_hours += needed
                current_exp += needed
            current_exp += exp

        return energy_hours + exp_hours