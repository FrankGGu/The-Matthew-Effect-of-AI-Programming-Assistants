class Solution:
    def minNumberOfHours(self, initialEnergy: int, initialExperience: int, energy: List[int], experience: List[int]) -> int:
        total_hours = 0
        required_energy = sum(energy) + 1
        required_experience = 0

        for exp in experience:
            if initialExperience <= exp:
                required_experience += (exp + 1 - initialExperience)
                initialExperience = exp + 1
            initialExperience += exp

        if initialEnergy < required_energy:
            total_hours += required_energy - initialEnergy

        total_hours += required_experience

        return total_hours