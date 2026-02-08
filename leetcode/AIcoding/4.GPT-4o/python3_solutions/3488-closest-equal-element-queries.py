class Solution:
    def closestQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict
        index_map = defaultdict(list)

        for idx, num in enumerate(nums):
            index_map[num].append(idx)

        result = []
        for x, y in queries:
            if x not in index_map:
                result.append(-1)
                continue

            positions = index_map[x]
            closest = float('inf')
            for pos in positions:
                if pos >= y:
                    closest = min(closest, pos)
            result.append(closest if closest != float('inf') else -1)

        return result