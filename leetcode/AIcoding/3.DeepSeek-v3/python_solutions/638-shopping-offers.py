class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        memo = {}

        def dfs(needs):
            key = tuple(needs)
            if key in memo:
                return memo[key]

            cost = sum(n * p for n, p in zip(needs, price))

            for offer in special:
                new_needs = []
                valid = True
                for i in range(len(needs)):
                    if offer[i] > needs[i]:
                        valid = False
                        break
                    new_needs.append(needs[i] - offer[i])
                if valid:
                    cost = min(cost, offer[-1] + dfs(new_needs))

            memo[key] = cost
            return cost

        return dfs(needs)