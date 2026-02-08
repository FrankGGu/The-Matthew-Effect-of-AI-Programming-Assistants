class Solution:
    def countHouses(self, houses: List[int], d: int) -> int:
        houses.sort()
        n = len(houses)
        count = 0
        j = 0

        for i in range(n):
            while j < n and houses[j] - houses[i] <= d:
                j += 1
            count += j - i - 1

        return count