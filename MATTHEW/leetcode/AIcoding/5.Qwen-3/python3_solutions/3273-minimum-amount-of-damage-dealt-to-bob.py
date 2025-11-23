class Solution:
    def minDamage(self, power: int, damage: List[int], health: List[int]) -> int:
        from collections import defaultdict

        monsters = list(zip(health, damage))
        monsters.sort(key=lambda x: (x[0] // power, x[1]))

        total_damage = 0
        for h, d in monsters:
            hits = (h + power - 1) // power
            total_damage += hits * d

        return total_damage