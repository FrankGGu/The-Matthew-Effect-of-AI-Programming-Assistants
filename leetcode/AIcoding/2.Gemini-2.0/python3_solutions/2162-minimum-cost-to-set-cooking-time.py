class Solution:
    def minCostSetTime(self, startAt: int, moveCost: int, pushCost: int, targetSeconds: int) -> int:
        min_cost = float('inf')

        minutes = targetSeconds // 60
        seconds = targetSeconds % 60

        if minutes > 99:
            minutes = 99
            seconds = targetSeconds - 99 * 60

        for m in range(max(0, minutes - 1), min(100, minutes + 2)):
            s = targetSeconds - m * 60
            if 0 <= s <= 99:
                time_str = "{:02d}{:02d}".format(m, s)
                cost = 0
                current_digit = startAt
                first_digit = False

                for digit in time_str:
                    if not first_digit and digit == '0' and m > 0:
                        continue
                    else:
                        first_digit = True
                        digit = int(digit)
                        if digit != current_digit:
                            cost += moveCost
                            current_digit = digit
                        cost += pushCost

                min_cost = min(min_cost, cost)

        return min_cost