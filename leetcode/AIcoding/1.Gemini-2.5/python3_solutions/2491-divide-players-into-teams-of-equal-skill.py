class Solution:
    def dividePlayers(self, skill: list[int]) -> int:
        skill.sort()
        n = len(skill)

        if n < 2:
            return -1 # Should not happen based on constraints (n is even, >=2)

        total_chemistry = 0
        expected_team_skill = skill[0] + skill[n - 1]

        left = 0
        right = n - 1

        while left < right:
            current_team_skill = skill[left] + skill[right]
            if current_team_skill != expected_team_skill:
                return -1

            total_chemistry += skill[left] * skill[right]

            left += 1
            right -= 1

        return total_chemistry