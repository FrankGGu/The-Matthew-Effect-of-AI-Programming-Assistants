class Solution:
    def minimumHealth(self, damage: List[int], armor: int) -> int:
        total_damage = sum(damage)
        effective_armor = min(armor, max(damage))
        total_damage -= effective_armor
        return total_damage + 1