class Solution:
    def maxProfit(self, inventory: list[int], orders: int) -> int:
        MOD = 10**9 + 7

        def get_sum_arith_series_mod(start, end, mod):
            if start > end:
                return 0

            n = end - start + 1

            term1 = (start % mod + end % mod) % mod
            term2 = n % mod

            inv2 = pow(2, mod - 2, mod)

            return (term1 * term2 % mod * inv2) % mod

        inventory.sort(reverse=True)
        inventory.append(0) 

        total_profit = 0
        count_at_current_level = 0 

        for i in range(len(inventory) - 1):
            current_val = inventory[i]
            count_at_current_level += 1
            next_val = inventory[i+1]

            if current_val == next_val:
                continue

            diff = current_val - next_val

            balls_to_sell_from_this_level = count_at_current_level * diff

            if orders >= balls_to_sell_from_this_level:
                sum_for_one_color = get_sum_arith_series_mod(next_val + 1, current_val, MOD)

                total_profit = (total_profit + count_at_current_level * sum_for_one_color) % MOD
                orders -= balls_to_sell_from_this_level
            else:
                q = orders // count_at_current_level
                r = orders % count_at_current_level

                sum_for_q_balls_per_color = get_sum_arith_series_mod(current_val - q + 1, current_val, MOD)
                total_profit = (total_profit + count_at_current_level * sum_for_q_balls_per_color) % MOD

                total_profit = (total_profit + r * (current_val - q)) % MOD
                orders = 0 
                break

            if orders == 0:
                break

        return total_profit