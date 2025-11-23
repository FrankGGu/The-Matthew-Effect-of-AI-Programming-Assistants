class Solution:
    def dividePlayers(self, skill: List[int]) -> int:
        skill.sort()
        n = len(skill)
        total = 0
        for i in range(n // 2):
            if skill[i] + skill[n - 1 - i] != skill[0] + skill[-1]:
                return -1
            total += skill[i] * skill[n - 1 - i]
        return total