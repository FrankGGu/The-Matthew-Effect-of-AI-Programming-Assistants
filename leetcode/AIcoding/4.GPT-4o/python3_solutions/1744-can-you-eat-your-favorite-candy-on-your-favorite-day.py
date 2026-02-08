class Solution:
    def canEat(self, candiesCount: List[int], queries: List[List[int]]) -> List[bool]:
        prefix_sum = list(itertools.accumulate(candiesCount))
        result = []

        for favoriteType, favoriteDay, dailyCap in queries:
            totalCandiesBefore = prefix_sum[favoriteType - 1] if favoriteType > 0 else 0
            totalCandies = prefix_sum[favoriteType]
            minCandiesNeeded = favoriteDay + 1
            maxCandiesPossible = (favoriteDay + 1) * dailyCap

            result.append(not (minCandiesNeeded > maxCandiesPossible or totalCandiesBefore >= maxCandiesPossible or totalCandies <= totalCandiesBefore))

        return result