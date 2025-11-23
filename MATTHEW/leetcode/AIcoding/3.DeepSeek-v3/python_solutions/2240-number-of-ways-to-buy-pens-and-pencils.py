class Solution:
    def waysToBuyPensPencils(self, total: int, cost1: int, cost2: int) -> int:
        ways = 0
        max_pens = total // cost1
        for pens in range(max_pens + 1):
            remaining = total - pens * cost1
            pencils = remaining // cost2
            ways += pencils + 1
        return ways