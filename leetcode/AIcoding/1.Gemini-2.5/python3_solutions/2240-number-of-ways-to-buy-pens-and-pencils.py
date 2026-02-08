class Solution:
    def waysToBuyPensPencils(self, total: int, cost1: int, cost2: int) -> int:
        count = 0
        for num_pens in range(total // cost1 + 1):
            money_spent_on_pens = num_pens * cost1
            remaining_money = total - money_spent_on_pens

            num_pencils_possible = remaining_money // cost2

            count += (num_pencils_possible + 1)

        return count