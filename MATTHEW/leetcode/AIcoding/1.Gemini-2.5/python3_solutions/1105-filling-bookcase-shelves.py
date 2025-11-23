class Solution:
    def minHeightShelves(self, books: list[list[int]], shelfWidth: int) -> int:
        n = len(books)
        dp = [0] * (n + 1)

        for i in range(1, n + 1):
            current_width = 0
            current_max_height = 0
            dp[i] = float('inf')

            for j in range(i - 1, -1, -1):
                book_width = books[j][0]
                book_height = books[j][1]

                current_width += book_width
                if current_width > shelfWidth:
                    break

                current_max_height = max(current_max_height, book_height)
                dp[i] = min(dp[i], dp[j] + current_max_height)

        return dp[n]