class Solution:
    def minTimeToBrew(self, time: List[int], total: int) -> int:
        left, right = 1, max(time) * total

        while left < right:
            mid = (left + right) // 2
            brewed = sum(mid // t for t in time)

            if brewed >= total:
                right = mid
            else:
                left = mid + 1

        return left