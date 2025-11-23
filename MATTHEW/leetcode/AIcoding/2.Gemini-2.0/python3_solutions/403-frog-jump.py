class Solution:
    def canCross(self, stones: List[int]) -> bool:
        if stones[1] != 1:
            return False
        n = len(stones)
        dp = {stone: set() for stone in stones}
        dp[1].add(1)

        for stone in stones:
            for k in dp[stone]:
                for step in [k - 1, k, k + 1]:
                    if step > 0 and stone + step in dp:
                        dp[stone + step].add(step)

        return len(dp[stones[-1]]) > 0