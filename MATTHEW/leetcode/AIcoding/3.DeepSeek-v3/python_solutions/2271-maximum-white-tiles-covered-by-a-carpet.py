class Solution:
    def maximumWhiteTiles(self, tiles: List[List[int]], carpetLen: int) -> int:
        tiles.sort()
        n = len(tiles)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + (tiles[i][1] - tiles[i][0] + 1)

        res = 0
        for i in range(n):
            start, end = tiles[i]
            if end >= start + carpetLen - 1:
                return carpetLen
            target = start + carpetLen - 1
            left, right = i, n - 1
            best = i
            while left <= right:
                mid = (left + right) // 2
                if tiles[mid][0] <= target:
                    best = mid
                    left = mid + 1
                else:
                    right = mid - 1
            curr = prefix[best] - prefix[i]
            if best + 1 < n and tiles[best][1] < target:
                curr += max(0, target - tiles[best + 1][0] + 1)
            res = max(res, curr)
        return res