class Solution:
    def minCostSetTime(self, startAt: int, moveCost: int, pushCost: int, targetSeconds: int) -> int:
        def cost(m, s):
            digits = []
            if m > 0:
                digits.extend(list(map(int, str(m))))
            s_digits = list(map(int, str(s)))
            if m > 0 and len(s_digits) < 2:
                s_digits = [0] * (2 - len(s_digits)) + s_digits
            digits.extend(s_digits)
            total_cost = 0
            current_pos = startAt
            for d in digits:
                if d != current_pos:
                    total_cost += moveCost
                    current_pos = d
                total_cost += pushCost
            return total_cost

        min_cost = float('inf')
        max_m = min(targetSeconds // 60, 99)
        for m in range(max_m + 1):
            s = targetSeconds - m * 60
            if s < 0 or s > 99:
                continue
            current_cost = cost(m, s)
            if current_cost < min_cost:
                min_cost = current_cost
        return min_cost