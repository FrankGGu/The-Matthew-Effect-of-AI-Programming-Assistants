class Solution:
    def findRadius(self, houses: List[int], heaters: List[int]) -> int:
        heaters.sort()
        houses.sort()
        res = 0
        for house in houses:
            left, right = 0, len(heaters) - 1
            while left < right:
                mid = (left + right) // 2
                if heaters[mid] < house:
                    left = mid + 1
                else:
                    right = mid
            res = max(res, abs(heaters[left] - house))
        return res