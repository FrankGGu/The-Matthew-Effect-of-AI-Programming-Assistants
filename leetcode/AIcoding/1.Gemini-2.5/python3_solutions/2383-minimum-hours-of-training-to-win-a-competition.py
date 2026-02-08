class Solution:
    def minNumberOfHours(self, initialEnergy: int, initialExperience: int, energy: list[int], experience: list[int]) -> int:
        added_energy = 0
        added_experience = 0

        current_energy = initialEnergy
        current_experience = initialExperience

        for i in range(len(energy)):
            # Check energy requirement
            if current_energy <= energy[i]:
                diff = energy[i] + 1 - current_energy
                added_energy += diff
                current_energy += diff 

            # After potentially adding energy, consume it for the battle
            current_energy -= energy[i]

            # Check experience requirement
            if current_experience <= experience[i]:
                diff = experience[i] + 1 - current_experience
                added_experience += diff
                current_experience += diff 

            # After potentially adding experience, gain experience from the battle
            current_experience += experience[i]

        return added_energy + added_experience