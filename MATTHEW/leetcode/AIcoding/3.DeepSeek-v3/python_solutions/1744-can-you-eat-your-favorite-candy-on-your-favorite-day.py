class Solution:
    def canEat(self, candiesCount: List[int], queries: List[List[int]]) -> List[bool]:
        prefix = [0] * (len(candiesCount) + 1)
        for i in range(len(candiesCount)):
            prefix[i+1] = prefix[i] + candiesCount[i]

        res = []
        for query in queries:
            favoriteType, favoriteDay, dailyCap = query
            min_candies = favoriteDay + 1
            max_candies = (favoriteDay + 1) * dailyCap
            total_before = prefix[favoriteType]
            total_until = prefix[favoriteType + 1]

            if min_candies > total_until or max_candies <= total_before:
                res.append(False)
            else:
                res.append(True)
        return res