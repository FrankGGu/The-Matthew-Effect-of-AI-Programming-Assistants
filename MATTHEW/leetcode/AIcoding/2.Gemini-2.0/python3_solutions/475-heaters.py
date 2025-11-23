class Solution:
    def findRadius(self, houses: list[int], heaters: list[int]) -> int:
        heaters.sort()
        radius = 0
        for house in houses:
            l, r = 0, len(heaters) - 1
            min_dist = float('inf')
            while l <= r:
                mid = (l + r) // 2
                dist = abs(heaters[mid] - house)
                min_dist = min(min_dist, dist)
                if heaters[mid] < house:
                    l = mid + 1
                else:
                    r = mid - 1
            if l > 0:
                min_dist = min(min_dist, abs(heaters[l - 1] - house))
            radius = max(radius, min_dist)
        return radius