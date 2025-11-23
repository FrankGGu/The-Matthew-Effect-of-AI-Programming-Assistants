class Solution:
    def getProbability(self, balls: List[str]) -> List[float]:
        from collections import Counter
        from math import comb

        total = 0
        same = 0

        def dfs(pos, left, right, same_count):
            nonlocal total, same
            if pos == len(balls):
                if left == right:
                    same += 1
                total += 1
                return
            color = balls[pos]
            count = Counter(color)
            for i in range(1, count['b'] + 1):
                if left + i <= len(balls) * 2 and right + (count['b'] - i) <= len(balls) * 2:
                    dfs(pos + 1, left + i, right + (count['b'] - i), same_count + (i == count['b'] - i))
            return

        dfs(0, 0, 0, 0)
        return [same / total, total / (comb(len(balls) * 2, len(balls)))]