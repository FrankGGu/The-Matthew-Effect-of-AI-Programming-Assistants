import heapq

class Solution:
    def longestDiverseString(self, a: int, b: int, c: int) -> str:
        heap = []
        if a > 0:
            heapq.heappush(heap, (-a, 'a'))
        if b > 0:
            heapq.heappush(heap, (-b, 'b'))
        if c > 0:
            heapq.heappush(heap, (-c, 'c'))

        result = ""

        while heap:
            count, char = heapq.heappop(heap)

            if len(result) >= 2 and result[-1] == char and result[-2] == char:
                if not heap:
                    break

                count2, char2 = heapq.heappop(heap)
                result += char2
                count2 += 1
                if count2 < 0:
                    heapq.heappush(heap, (count2, char2))
                heapq.heappush(heap, (count, char))
            else:
                result += char
                count += 1
                if count < 0:
                    heapq.heappush(heap, (count, char))

        return result