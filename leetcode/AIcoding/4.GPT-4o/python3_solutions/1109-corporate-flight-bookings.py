class Solution:
    def corpFlightBookings(self, bookings: List[List[int]], n: int) -> List[int]:
        ans = [0] * n
        for start, end, seats in bookings:
            ans[start - 1] += seats
            if end < n:
                ans[end] -= seats
        for i in range(1, n):
            ans[i] += ans[i - 1]
        return ans