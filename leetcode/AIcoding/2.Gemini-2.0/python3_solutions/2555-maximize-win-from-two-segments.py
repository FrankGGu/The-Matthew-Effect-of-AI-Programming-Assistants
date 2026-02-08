class Solution:
    def maximizeWin(self, prizePositions: list[int], k: int) -> int:
        n = len(prizePositions)
        max_win = 0
        for i in range(n):
            j = i
            while j < n and prizePositions[j] - prizePositions[i] <= k:
                j += 1
            len1 = j - i
            max_win = max(max_win, len1)

        for i in range(n):
            j = i
            while j < n and prizePositions[j] - prizePositions[i] <= k:
                j += 1
            len1 = j - i

            right_max = 0
            for l in range(j, n):
                r = l
                while r < n and prizePositions[r] - prizePositions[l] <= k:
                    r += 1
                len2 = r - l
                right_max = max(right_max, len2)

            max_win = max(max_win, len1 + right_max)

        return max_win