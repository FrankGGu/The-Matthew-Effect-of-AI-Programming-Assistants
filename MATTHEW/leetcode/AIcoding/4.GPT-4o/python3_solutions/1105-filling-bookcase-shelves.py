class Solution:
    def minHeightShelves(self, books: List[List[int]], shelf_width: int) -> int:
        dp = [0] * (len(books) + 1)

        for i in range(1, len(books) + 1):
            width = 0
            max_height = 0
            for j in range(i, 0, -1):
                width += books[j - 1][0]
                if width > shelf_width:
                    break
                max_height = max(max_height, books[j - 1][1])
                dp[i] = max(dp[i], dp[j - 1] + max_height)

        return dp[len(books)]