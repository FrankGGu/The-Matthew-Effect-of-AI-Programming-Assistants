class Solution:
    def strongestSpell(self, spells: List[int], power: List[int]) -> int:
        return max(spell * p for spell, p in zip(spells, power))