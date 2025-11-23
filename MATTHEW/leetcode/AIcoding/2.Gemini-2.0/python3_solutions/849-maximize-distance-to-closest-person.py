class Solution:
    def maxDistToClosest(self, seats: list[int]) -> int:
        n = len(seats)
        left = [-1] * n
        right = [-1] * n

        last = -1
        for i in range(n):
            if seats[i] == 1:
                last = i
            left[i] = last

        last = -1
        for i in range(n - 1, -1, -1):
            if seats[i] == 1:
                last = i
            right[i] = last

        ans = 0
        for i in range(n):
            if seats[i] == 0:
                l = left[i]
                r = right[i]
                if l == -1:
                    ans = max(ans, r - i)
                elif r == -1:
                    ans = max(ans, i - l)
                else:
                    ans = max(ans, min(i - l, r - i))

        return ans