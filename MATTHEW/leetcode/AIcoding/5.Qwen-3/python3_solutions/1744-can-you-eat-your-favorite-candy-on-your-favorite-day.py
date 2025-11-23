class Solution:
    def canEat(self, candiesCount: List[int], favoriteDay: int, favoriteDayCandy: int, favoriteDayIndex: int) -> bool:
        total = 0
        for i in range(favoriteDayIndex):
            total += candiesCount[i]
        return total < favoriteDayCandy * (favoriteDay + 1) and total + candiesCount[favoriteDayIndex] > favoriteDayCandy * favoriteDay