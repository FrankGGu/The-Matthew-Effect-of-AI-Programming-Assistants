class Solution:
    def maxDistToClosest(self, seats: List[int]) -> int:
        n = len(seats)
        left = [n] * n
        right = [n] * n

        for i in range(n):
            if seats[i] == 1:
                left[i] = 0
            elif i > 0:
                left[i] = left[i-1] + 1

        for i in range(n-1, -1, -1):
            if seats[i] == 1:
                right[i] = 0
            elif i < n-1:
                right[i] = right[i+1] + 1

        max_dist = 0
        for i in range(n):
            if seats[i] == 0:
                max_dist = max(max_dist, min(left[i], right[i]))

        return max_dist