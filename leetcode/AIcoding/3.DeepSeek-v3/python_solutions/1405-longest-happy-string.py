class Solution:
    def longestDiverseString(self, a: int, b: int, c: int) -> str:
        max_heap = []
        if a > 0:
            heapq.heappush(max_heap, (-a, 'a'))
        if b > 0:
            heapq.heappush(max_heap, (-b, 'b'))
        if c > 0:
            heapq.heappush(max_heap, (-c, 'c'))

        res = []
        while max_heap:
            count, char = heapq.heappop(max_heap)
            if len(res) >= 2 and res[-1] == res[-2] == char:
                if not max_heap:
                    break
                next_count, next_char = heapq.heappop(max_heap)
                res.append(next_char)
                next_count += 1
                if next_count < 0:
                    heapq.heappush(max_heap, (next_count, next_char))
                heapq.heappush(max_heap, (count, char))
            else:
                res.append(char)
                count += 1
                if count < 0:
                    heapq.heappush(max_heap, (count, char))

        return ''.join(res)