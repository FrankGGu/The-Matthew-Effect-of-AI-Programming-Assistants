class Solution:
    def waysToBuyPensPencils(self, total: int, cost1: int, cost2: int, amount1: int, amount2: int) -> int:
        ways = 0
        for i in range(amount1 + 1):
            remaining = total - i * cost1
            if remaining >= 0:
                ways += remaining // cost2 + 1
            else:
                break
        return ways