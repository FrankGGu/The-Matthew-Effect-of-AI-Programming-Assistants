class Solution:
    def maximumWhiteTiles(self, tiles: List[List[int]], carpetLen: int) -> int:
        tiles.sort()
        prefix_sum = [0] * (len(tiles) + 1)

        for i in range(len(tiles)):
            prefix_sum[i + 1] = prefix_sum[i] + tiles[i][1] - tiles[i][0] + 1

        max_covered = 0
        j = 0

        for i in range(len(tiles)):
            while j < len(tiles) and tiles[j][0] - tiles[i][0] < carpetLen:
                j += 1
            covered = prefix_sum[j] - prefix_sum[i]
            if j > 0 and tiles[j - 1][1] >= tiles[i][0] + carpetLen - 1:
                covered -= max(0, tiles[j - 1][1] - (tiles[i][0] + carpetLen - 1))
            max_covered = max(max_covered, covered)

        return max_covered