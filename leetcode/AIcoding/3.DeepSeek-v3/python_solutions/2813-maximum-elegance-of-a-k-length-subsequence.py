class Solution:
    def findMaximumElegance(self, items: List[List[int]], k: int) -> int:
        items.sort(reverse=True)
        res = 0
        cur = 0
        dup = []
        seen = set()

        for i in range(len(items)):
            profit, category = items[i]
            if i < k:
                if category in seen:
                    dup.append(profit)
                cur += profit
            else:
                if category not in seen and dup:
                    cur += profit - dup.pop()
            seen.add(category)
            res = max(res, cur + len(seen) ** 2)

        return res