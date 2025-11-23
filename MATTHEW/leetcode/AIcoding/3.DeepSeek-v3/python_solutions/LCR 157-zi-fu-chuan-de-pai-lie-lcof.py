class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        memo = {}

        def dfs(needs):
            key = tuple(needs)
            if key in memo:
                return memo[key]

            cost = sum(price[i] * needs[i] for i in range(len(needs)))

            for offer in special:
                new_needs = list(needs)
                valid = True
                for i in range(len(needs)):
                    if offer[i] > new_needs[i]:
                        valid = False
                        break
                    new_needs[i] -= offer[i]
                if valid:
                    cost = min(cost, offer[-1] + dfs(new_needs))

            memo[key] = cost
            return cost

        return dfs(needs)