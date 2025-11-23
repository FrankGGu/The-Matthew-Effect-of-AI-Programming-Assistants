import heapq

class Solution:
    def eatenApples(self, apples: list[int], days: list[int]) -> int:
        eaten_apples = 0
        # Min-heap to store (spoil_day, count)
        # spoil_day is the day *after* which the apple cannot be eaten.
        # For an apple grown on day 'i' with shelf life 'days[i]', it can be eaten
        # on days i, i+1, ..., i + days[i] - 1.
        # It spoils on day i + days[i].
        heap = [] 

        n = len(apples)
        day = 0

        # Continue as long as there are new apples to consider or apples in the heap
        while day < n or heap:
            # 1. Add new apples that grow on current 'day'
            if day < n and apples[day] > 0:
                spoil_day = day + days[day]
                heapq.heappush(heap, (spoil_day, apples[day]))

            # 2. Remove apples that have already spoiled
            # If an apple's spoil_day is 'X', it cannot be eaten on day 'X'.
            # So, if heap[0][0] <= day, it means this apple spoiled on or before 'day'.
            while heap and heap[0][0] <= day:
                heapq.heappop(heap)

            # 3. Eat an apple if available
            if heap:
                spoil_day, count = heapq.heappop(heap)
                eaten_apples += 1
                count -= 1
                # If there are still apples of this batch left, push them back
                if count > 0:
                    heapq.heappush(heap, (spoil_day, count))

            day += 1

        return eaten_apples