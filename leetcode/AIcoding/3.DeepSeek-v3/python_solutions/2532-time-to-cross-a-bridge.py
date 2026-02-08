import heapq

class Solution:
    def findCrossingTime(self, n: int, k: int, time: List[List[int]]) -> int:
        left_waiting = []
        right_waiting = []
        left_working = []
        right_working = []

        for i in range(k):
            l2r, pick, r2l, put = time[i]
            heapq.heappush(left_waiting, (-(l2r + r2l), -i))

        current_time = 0
        while n > 0 or right_waiting or right_working:
            while left_working and left_working[0][0] <= current_time:
                t, i = heapq.heappop(left_working)
                heapq.heappush(left_waiting, (-(time[i][0] + time[i][2]), -i))

            while right_working and right_working[0][0] <= current_time:
                t, i = heapq.heappop(right_working)
                heapq.heappush(right_waiting, (-(time[i][0] + time[i][2]), -i))

            if right_waiting:
                _, neg_i = heapq.heappop(right_waiting)
                i = -neg_i
                current_time += time[i][2]
                heapq.heappush(left_working, (current_time + time[i][3], i))
            elif left_waiting and n > 0:
                _, neg_i = heapq.heappop(left_waiting)
                i = -neg_i
                current_time += time[i][0]
                heapq.heappush(right_working, (current_time + time[i][1], i))
                n -= 1
            else:
                next_time = float('inf')
                if left_working:
                    next_time = min(next_time, left_working[0][0])
                if right_working:
                    next_time = min(next_time, right_working[0][0])
                if next_time != float('inf'):
                    current_time = max(current_time, next_time)
                else:
                    break

        return current_time