class Solution:
    def closestRoom(self, rooms: List[List[int]], queries: List[List[int]]) -> List[int]:
        from sortedcontainers import SortedList

        n = len(rooms)
        room_map = {r[0]: r[1] for r in rooms}
        queries = [(l, x, i) for i, (x, l) in enumerate(queries)]
        queries.sort(key=lambda x: -x[1])

        sorted_sizes = SortedList()
        results = [-1] * len(queries)

        j = 0
        for l, x, idx in queries:
            while j < n and (l >= 0 or (j < n and rooms[j][1] >= l)):
                sorted_sizes.add(rooms[j][0])
                j += 1

            if x in room_map:
                results[idx] = x
                continue

            if sorted_sizes:
                pos = sorted_sizes.bisect_right(x)
                if pos > 0:
                    results[idx] = sorted_sizes[pos - 1]
                if pos < len(sorted_sizes):
                    results[idx] = max(results[idx], sorted_sizes[pos])

        return results