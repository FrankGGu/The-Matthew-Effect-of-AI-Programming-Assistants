class Solution:
    def longestHappyString(self, a: int, b: int, c: int) -> str:
        from collections import deque

        max_heap = []
        if a > 0:
            max_heap.append((-a, 'a'))
        if b > 0:
            max_heap.append((-b, 'b'))
        if c > 0:
            max_heap.append((-c, 'c'))

        import heapq
        heapq.heapify(max_heap)

        result = []
        prev_char = ''
        prev_count = 0

        while max_heap:
            count, char = heapq.heappop(max_heap)
            if char == prev_char:
                if not max_heap:
                    break
                count2, char2 = heapq.heappop(max_heap)
                result.append(char2)
                count2 += 1
                if count2 < 0:
                    heapq.heappush(max_heap, (count2, char2))
                heapq.heappush(max_heap, (count, char))
                prev_char = char2
                prev_count = 1
            else:
                result.append(char)
                count += 1
                if count < 0:
                    heapq.heappush(max_heap, (count, char))
                prev_char = char
                prev_count = 1

        return ''.join(result)