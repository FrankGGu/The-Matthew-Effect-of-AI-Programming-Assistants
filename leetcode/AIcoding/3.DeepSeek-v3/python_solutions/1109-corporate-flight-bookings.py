class Solution:
    def corpFlightBookings(self, bookings: List[List[int]], n: int) -> List[int]:
        res = [0] * (n + 2)
        for first, last, seats in bookings:
            res[first] += seats
            if last + 1 <= n:
                res[last + 1] -= seats
        for i in range(1, n + 1):
            res[i] += res[i - 1]
        return res[1:n + 1]