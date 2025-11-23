from typing import List

class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        n = len(price)
        memo = {}

        valid_special_offers = []
        for offer in special:
            offer_price = offer[-1]
            individual_cost_for_offer_items = sum(offer[i] * price[i] for i in range(n))
            if offer_price < individual_cost_for_offer_items:
                valid_special_offers.append(offer)

        def dfs(current_needs_tuple):
            if current_needs_tuple in memo:
                return memo[current_needs_tuple]

            current_needs_list = list(current_needs_tuple)

            min_cost = sum(current_needs_list[i] * price[i] for i in range(n))

            for offer in valid_special_offers:
                can_apply = True
                next_needs_list = [0] * n
                for i in range(n):
                    if current_needs_list[i] < offer[i]:
                        can_apply = False
                        break
                    next_needs_list[i] = current_needs_list[i] - offer[i]

                if can_apply:
                    offer_cost = offer[-1]
                    min_cost = min(min_cost, offer_cost + dfs(tuple(next_needs_list)))

            memo[current_needs_tuple] = min_cost
            return min_cost

        return dfs(tuple(needs))