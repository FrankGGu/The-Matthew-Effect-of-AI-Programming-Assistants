class Solution:
    def maximumWhiteTiles(self, tiles: list[list[int]], carpetLen: int) -> int:
        tiles.sort()
        n = len(tiles)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + (tiles[i][1] - tiles[i][0] + 1)

        max_covered = 0
        for i in range(n):
            start = tiles[i][0]
            end = start + carpetLen - 1

            left, right = i, n - 1
            j = i
            while left <= right:
                mid = (left + right) // 2
                if tiles[mid][1] <= end:
                    j = mid
                    left = mid + 1
                else:
                    right = mid - 1

            covered = prefix_sum[j + 1] - prefix_sum[i]

            if tiles[j][1] < end:
                max_covered = max(max_covered, covered)
            else:
                covered += min(end - tiles[j][0] + 1, tiles[j][1] - tiles[j][0] + 1)
                max_covered = max(max_covered, covered)

        return max_covered