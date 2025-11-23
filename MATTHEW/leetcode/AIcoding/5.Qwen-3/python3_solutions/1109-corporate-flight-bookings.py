class Solution:
    def findResv(self, bookings, n):
        res = [0] * n
        for i, j, k in bookings:
            res[i - 1] += k
            if j < n:
                res[j] -= k
        for i in range(1, n):
            res[i] += res[i - 1]
        return res