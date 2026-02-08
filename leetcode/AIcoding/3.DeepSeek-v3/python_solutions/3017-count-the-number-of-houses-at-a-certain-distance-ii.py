class Solution:
    def countOfPairs(self, n: int, x: int, y: int) -> List[int]:
        if x > y:
            x, y = y, x
        res = [0] * n
        for i in range(1, n + 1):
            for j in range(i + 1, n + 1):
                d = min(j - i, abs(x - i) + 1 + abs(y - j))
                res[d - 1] += 2
        return res