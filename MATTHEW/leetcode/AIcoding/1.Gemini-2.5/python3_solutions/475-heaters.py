import bisect

class Solution:
    def findRadius(self, houses: list[int], heaters: list[int]) -> int:
        houses.sort()
        heaters.sort()

        def check(r: int) -> bool:
            n = len(houses)
            m = len(heaters)

            heater_idx = 0
            for i in range(n):
                house_pos = houses[i]

                while heater_idx < m - 1 and \
                      abs(heaters[heater_idx + 1] - house_pos) <= abs(heaters[heater_idx] - house_pos):
                    heater_idx += 1

                if abs(heaters[heater_idx] - house_pos) > r:
                    return False
            return True

        left = 0
        right = 10**9 + 7 
        ans = right

        while left <= right:
            mid = (left + right) // 2
            if check(mid):
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans