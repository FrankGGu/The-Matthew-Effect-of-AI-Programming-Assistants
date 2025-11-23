class Solution:
    def longestObstacleCourseAtEachPosition(self, obstacles: list[int]) -> list[int]:
        tails = []
        result = []
        for obstacle in obstacles:
            l, r = 0, len(tails)
            while l < r:
                mid = (l + r) // 2
                if tails[mid] <= obstacle:
                    l = mid + 1
                else:
                    r = mid
            if l == len(tails):
                tails.append(obstacle)
            else:
                tails[l] = obstacle
            result.append(l + 1)
        return result