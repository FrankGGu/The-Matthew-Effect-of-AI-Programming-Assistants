class Solution:
    def waysToBuyPensPencils(self, total: int, cost1: int, cost2: int) -> int:
        count = 0
        for pens in range(total // cost1 + 1):
            remaining = total - pens * cost1
            count += remaining // cost2 + 1
        return count