class Solution:
    def findMaximumElegance(self, items: list[list[int]], k: int) -> int:
        items.sort(key=lambda x: x[0], reverse=True)
        profit = 0
        seen = set()
        remaining = []
        for i in range(k):
            if items[i][1] not in seen:
                profit += items[i][0]
                seen.add(items[i][1])
            else:
                remaining.append(items[i][0])

        ans = profit + len(seen) * len(seen)

        for i in range(k, len(items)):
            if items[i][1] not in seen and remaining:
                removed = remaining.pop()
                profit = profit - removed + items[i][0]
                seen.add(items[i][1])
                ans = max(ans, profit + len(seen) * len(seen))

        return ans