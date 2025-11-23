import heapq

class Solution:
    def furthestBuilding(self, heights: list[int], bricks: int, ladders: int) -> int:
        min_heap = []

        for i in range(len(heights) - 1):
            climb = heights[i+1] - heights[i]

            if climb > 0:
                heapq.heappush(min_heap, climb)

                if len(min_heap) > ladders:
                    smallest_climb = heapq.heappop(min_heap)
                    bricks -= smallest_climb

                if bricks < 0:
                    return i

        return len(heights) - 1