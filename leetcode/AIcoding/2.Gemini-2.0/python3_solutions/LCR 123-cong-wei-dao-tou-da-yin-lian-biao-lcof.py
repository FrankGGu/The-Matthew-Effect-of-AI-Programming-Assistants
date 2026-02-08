class Solution:
    def arrangeBooks(self, books: list[int]) -> int:
        n = len(books)
        dp = {}

        def solve(index, prev_width):
            if index == n:
                return 0

            if (index, prev_width) in dp:
                return dp[(index, prev_width)]

            ans = float('inf')

            if books[index] > prev_width:
                ans = min(ans, books[index] + solve(index + 1, books[index]))

            ans = min(ans, solve(index + 1, prev_width))

            dp[(index, prev_width)] = ans
            return ans

        return solve(0, 0)