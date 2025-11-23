class Solution:
    def countHouses(self, houses: List[int], distance: int) -> int:
        houses.sort()
        count = 0
        n = len(houses)

        for i in range(n):
            left = bisect.bisect_left(houses, houses[i] - distance)
            right = bisect.bisect_right(houses, houses[i] + distance)
            count += right - left - 1

        return count