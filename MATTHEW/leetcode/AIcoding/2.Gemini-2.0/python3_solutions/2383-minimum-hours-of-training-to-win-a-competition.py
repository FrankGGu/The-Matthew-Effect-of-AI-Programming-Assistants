class Solution:
    def minNumberOfHours(self, initialEnergy: int, initialExperience: int, energy: list[int], experience: list[int]) -> int:
        hours = 0
        current_energy = initialEnergy
        current_experience = initialExperience

        for e in energy:
            if current_energy <= e:
                hours += (e - current_energy + 1)
                current_energy = e + 1
            else:
                current_energy -= e

        for exp in experience:
            if current_experience <= exp:
                hours += (exp - current_experience + 1)
                current_experience = exp + 1
            current_experience += exp

        return hours