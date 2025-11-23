class Solution:
    def findRadius(self, houses: List[int], heaters: List[int]) -> int:
        houses.sort()
        heaters.sort()
        radius = 0
        h_index = 0
        for house in houses:
            while h_index < len(heaters) - 1 and abs(heaters[h_index + 1] - house) <= abs(heaters[h_index] - house):
                h_index += 1
            radius = max(radius, abs(heaters[h_index] - house))
        return radius