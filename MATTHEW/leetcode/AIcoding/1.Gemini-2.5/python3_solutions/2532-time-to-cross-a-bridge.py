import heapq

class Solution:
    def findCrossingTime(self, n: int, k: int, time: list[list[int]]) -> int:
        current_time = 0
        ans = 0
        boxes_moved = 0

        # Priority queues for workers waiting on banks, ready to cross
        # (priority_value, worker_id)
        # For left_waiting_pq: (leftToRight_i, worker_id) - min-heap for fastest L->R, then smallest index
        # For right_waiting_pq: (rightToLeft_i, worker_id) - min-heap for fastest R->L, then smallest index
        left_waiting_pq = []
        right_waiting_pq = []

        # Priority queues for workers delayed on banks (due to pickOld/putNew tasks)
        # (available_time, time_to_cross_next, worker_id)
        left_delayed_pq = []  # Workers finished R->L, putting down new box, then available for L->R
        right_delayed_pq = [] # Workers finished L->R, picking up old box, then available for R->L

        # Priority queues for workers currently crossing bridges
        # (finish_time, worker_id)
        left_crossing = []  # Workers crossing from left to right
        right_crossing = [] # Workers crossing from right to left

        # Initialize all available workers (len(time) workers) on the left bank, ready at time 0.
        # They are initially "delayed" by 0 time, meaning they are available to cross L->R immediately.
        # The `n` parameter refers to the number of boxes to be moved.
        for i in range(len(time)):
            # (available_time, leftToRight_i, worker_id)
            heapq.heappush(left_delayed_pq, (0, time[i][0], i))

        bridges_available = k

        while boxes_moved < n:
            # Step A: Advance time if nothing can happen at current_time
            # Find the earliest time an event occurs (a worker finishes crossing or becomes available)
            next_event_time = float('inf')
            if left_crossing:
                next_event_time = min(next_event_time, left_crossing[0][0])
            if right_crossing:
                next_event_time = min(next_event_time, right_crossing[0][0])
            if left_delayed_pq:
                next_event_time = min(next_event_time, left_delayed_pq[0][0])
            if right_delayed_pq:
                next_event_time = min(next_event_time, right_delayed_pq[0][0])

            # If no workers are ready to cross (neither in waiting_pq nor delayed_pq and available now)
            # AND all bridges are occupied, then we must advance time.
            # OR if no workers are ready to cross, but bridges are free, time must advance to when a worker becomes ready.
            if (not right_waiting_pq and not left_waiting_pq) or (bridges_available == 0):
                if next_event_time == float('inf'): # Should not happen if boxes_moved < n
                    break
                current_time = max(current_time, next_event_time)

            # Step B: Process events at current_time

            # B1. Bring delayed workers to ready queues if their available_time <= current_time
            while left_delayed_pq and left_delayed_pq[0][0] <= current_time:
                avail_t, lt_time, worker_id = heapq.heappop(left_delayed_pq)
                heapq.heappush(left_waiting_pq, (lt_time, worker_id))

            while right_delayed_pq and right_delayed_pq[0][0] <= current_time:
                avail_t, rt_time, worker_id = heapq.heappop(right_delayed_pq)
                heapq.heappush(right_waiting_pq, (rt_time, worker_id))

            # B2. Release bridges and update delayed queues for workers finishing crossing
            # Workers finishing L->R cross
            while left_crossing and left_crossing[0][0] <= current_time:
                finish_time, worker_id = heapq.heappop(left_crossing)
                bridges_available += 1
                # Worker picked up box, now delayed on right bank.
                # Becomes available to cross R->L at finish_time + time[worker_id][1] (pickOld_i)
                heapq.heappush(right_delayed_pq, (finish_time + time[worker_id][1], time[worker_id][2], worker_id))

            # Workers finishing R->L cross
            while right_crossing and right_crossing[0][0] <= current_time:
                finish_time, worker_id = heapq.heappop(right_crossing)
                bridges_available += 1
                # Worker put down box, now delayed on left bank.
                # Becomes available to cross L->R at finish_time + time[worker_id][3] (putNew_i)
                heapq.heappush(left_delayed_pq, (finish_time + time[worker_id][3], time[worker_id][0], worker_id))

            # Step C: Try to move workers onto bridges (R->L first, then L->R)

            # C1. R->L crossing (higher priority)
            # Workers crossing from right to left are prioritized to free up the right bank.
            while bridges_available > 0 and right_waiting_pq:
                rt_time, worker_id = heapq.heappop(right_waiting_pq)
                bridges_available -= 1
                heapq.heappush(right_crossing, (current_time + rt_time, worker_id))

            # C2. L->R crossing
            # Only if bridges are still available after checking R->L.
            while bridges_available > 0 and left_waiting_pq:
                lt_time, worker_id = heapq.heappop(left_waiting_pq)
                bridges_available -= 1
                heapq.heappush(left_crossing, (current_time + lt_time, worker_id))
                boxes_moved += 1
                ans = max(ans, current_time + lt_time) # Update max time a box reached the right bank
                if boxes_moved == n:
                    break # All boxes moved, goal reached

        return ans