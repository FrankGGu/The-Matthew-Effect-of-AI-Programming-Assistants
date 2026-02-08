class Solution:
    def maxEnergyBoost(self, drinks: list[int]) -> int:
        drinks.sort()
        return drinks[-1] + drinks[-2]