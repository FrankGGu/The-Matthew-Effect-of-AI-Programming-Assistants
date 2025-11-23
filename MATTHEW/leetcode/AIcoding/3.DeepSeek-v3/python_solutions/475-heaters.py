class Solution:
    def findRadius(self, houses: List[int], heaters: List[int]) -> int:
        heaters.sort()
        max_radius = 0
        for house in houses:
            left, right = 0, len(heaters) - 1
            while left <= right:
                mid = (left + right) // 2
                if heaters[mid] < house:
                    left = mid + 1
                else:
                    right = mid - 1
            min_dist = float('inf')
            if left < len(heaters):
                min_dist = heaters[left] - house
            if right >= 0:
                min_dist = min(min_dist, house - heaters[right])
            max_radius = max(max_radius, min_dist)
        return max_radius