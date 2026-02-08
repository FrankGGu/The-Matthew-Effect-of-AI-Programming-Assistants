class Solution:
    def longestDiverseString(self, a: int, b: int, c: int) -> str:
        res = []
        max_heap = [(-a, 'a'), (-b, 'b'), (-c, 'c')]

        while max_heap:
            max_heap.sort()
            count, char = max_heap.pop()
            count = -count

            if len(res) >= 2 and res[-1] == res[-2] == char:
                if not max_heap:
                    break
                next_count, next_char = max_heap.pop()
                res.append(next_char)
                next_count = -next_count - 1
                if next_count > 0:
                    max_heap.append((-next_count, next_char))
                max_heap.append((-count, char))
            else:
                res.append(char)
                count -= 1
                if count > 0:
                    max_heap.append((-count, char))

        return ''.join(res)