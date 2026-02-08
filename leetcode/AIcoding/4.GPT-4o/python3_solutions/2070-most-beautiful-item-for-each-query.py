class Solution:
    def mostBeautifulItem(self, items: List[List[int]], queries: List[int]) -> List[int]:
        items.sort(key=lambda x: (x[0], -x[1]))
        max_beauty = 0
        result = []
        j = 0

        for q in sorted(enumerate(queries), key=lambda x: x[1]):
            index, query = q
            while j < len(items) and items[j][0] <= query:
                max_beauty = max(max_beauty, items[j][1])
                j += 1
            result.append((index, max_beauty))

        result.sort()
        return [res[1] for res in result]