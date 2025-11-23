class Solution:
    def canCross(self, stones: List[int]) -> bool:
        n = len(stones)
        dp = {stone: set() for stone in stones}
        dp[0].add(0)

        for i in range(n):
            current_pos = stones[i]
            for k in dp[current_pos]:
                for step in [k - 1, k, k + 1]:
                    if step > 0 and current_pos + step in dp:
                        if current_pos + step == stones[-1]:
                            return True
                        dp[current_pos + step].add(step)
        return False