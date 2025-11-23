import heapq
import collections

class Solution:
    def getSkyline(self, buildings: list[list[int]]) -> list[list[int]]:
        events = []
        for L, R, H in buildings:
            events.append((L, -H)) # Start of building, use negative height
            events.append((R, H))  # End of building, use positive height

        # Sort events:
        # 1. By x-coordinate
        # 2. If x-coordinates are the same:
        #    - Start events (-H) before end events (H)
        #    - Among start events, taller buildings first (smaller -H value)
        #    - Among end events, shorter buildings first (smaller H value)
        events.sort()

        skyline = []
        # Max-heap to store current active heights (store negative heights for Python's min-heap)
        # We use a frequency map (collections.Counter) to track actual active heights,
        # which allows for "lazy" removal from the heap.
        active_heights_counts = collections.Counter()
        # The heap will store negative heights of active buildings.
        # Initialize with 0 to represent ground level.
        heap = [0] 

        prev_max_height = 0

        for x, h_indicator in events:
            if h_indicator < 0:  # Start of a building
                height = -h_indicator
                active_heights_counts[height] += 1
                heapq.heappush(heap, -height)
            else:  # End of a building
                height = h_indicator
                active_heights_counts[height] -= 1

            # Clean up the heap: remove heights that are no longer active
            # (i.e., their count in active_heights_counts is 0)
            while heap and active_heights_counts[-heap[0]] == 0:
                heapq.heappop(heap)

            # The current maximum height is the negative of the top of the heap
            current_max_height = -heap[0] 

            # If the current maximum height is different from the previous maximum height,
            # it means we've found a critical point.
            if current_max_height != prev_max_height:
                skyline.append([x, current_max_height])
                prev_max_height = current_max_height

        return skyline