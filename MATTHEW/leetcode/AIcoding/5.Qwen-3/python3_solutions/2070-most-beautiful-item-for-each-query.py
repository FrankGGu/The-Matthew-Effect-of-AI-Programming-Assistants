class Solution:
    def sortItems(self, items, queries):
        from collections import defaultdict

        def get_max_beauty(items, query):
            max_beauty = 0
            for item in items:
                if item[0] <= query:
                    max_beauty = max(max_beauty, item[1])
            return max_beauty

        items.sort()
        result = []
        for q in queries:
            result.append(get_max_beauty(items, q))
        return result