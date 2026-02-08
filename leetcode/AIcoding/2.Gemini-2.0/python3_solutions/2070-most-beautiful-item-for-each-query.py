class Solution:
    def maximumBeauty(self, items: List[List[int]], queries: List[int]) -> List[int]:
        items.sort()
        max_beauty = 0
        for i in range(len(items)):
            max_beauty = max(max_beauty, items[i][1])
            items[i][1] = max_beauty

        result = []
        for query in queries:
            l, r = 0, len(items) - 1
            ans = 0
            while l <= r:
                mid = (l + r) // 2
                if items[mid][0] <= query:
                    ans = items[mid][1]
                    l = mid + 1
                else:
                    r = mid - 1
            result.append(ans)
        return result