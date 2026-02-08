class Solution:
    def getSkyline(self, buildings: List[List[int]]) -> List[List[int]]:
        events = []
        for left, right, height in buildings:
            events.append((left, -height))
            events.append((right, height))

        events.sort()
        result = []
        heights = [0]
        heapq.heapify(heights)

        for x, h in events:
            if h < 0:
                heapq.heappush(heights, h)
            else:
                heights.remove(-h)
                heapq.heapify(heights)

            max_height = -heights[0]
            if not result or max_height != result[-1][1]:
                result.append([x, max_height])

        return result