class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        def dfs(needs):
            if all(n == 0 for n in needs):
                return 0
            res = sum(needs[i] * price[i] for i in range(len(needs)))
            for offer in special:
                new_needs = needs[:]
                for i in range(len(needs)):
                    new_needs[i] -= offer[i]
                    if new_needs[i] < 0:
                        break
                else:
                    res = min(res, offer[-1] + dfs(new_needs))
            return res

        return dfs(needs)