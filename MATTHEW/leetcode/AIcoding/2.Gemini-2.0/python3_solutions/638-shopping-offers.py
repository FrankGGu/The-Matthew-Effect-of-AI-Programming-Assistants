class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        def helper(cur_needs):
            min_price = sum(price[i] * cur_needs[i] for i in range(len(price)))

            for offer in special:
                temp_needs = cur_needs[:]
                valid = True
                for i in range(len(price)):
                    temp_needs[i] -= offer[i]
                    if temp_needs[i] < 0:
                        valid = False
                        break

                if valid:
                    min_price = min(min_price, offer[-1] + helper(temp_needs))

            return min_price

        return helper(needs)