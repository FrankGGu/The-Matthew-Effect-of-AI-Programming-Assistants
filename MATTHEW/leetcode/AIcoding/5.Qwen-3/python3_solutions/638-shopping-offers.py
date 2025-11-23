class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(needs):
            total = sum(price[i] * needs[i] for i in range(len(needs)))
            for offer in special:
                if all(offer[i] <= needs[i] for i in range(len(needs))):
                    new_needs = tuple(needs[i] - offer[i] for i in range(len(needs)))
                    total = min(total, dfs(new_needs) + offer[-1])
            return total

        return dfs(tuple(needs))