import heapq

class Solution:
    def timeToCross(self, n: int, k: int, time: List[List[int]]) -> int:
        left_wait = list(range(n - k))
        right_wait = []
        on_bridge = []
        finished = []
        t = 0
        workers = list(range(n - k, n))

        while finished or on_bridge or right_wait or left_wait:
            while on_bridge and on_bridge[0][0] <= t:
                _, worker_id, direction = heapq.heappop(on_bridge)
                if direction == 0:
                    finished.append(worker_id)
                else:
                    left_wait.append(worker_id)
                    left_wait.sort()

            while workers and (right_wait or left_wait):
                if right_wait:
                    worker_id = heapq.heappop(right_wait)[1]
                    heapq.heappush(on_bridge, (t + time[worker_id][2], worker_id, 0))
                    workers.remove(worker_id)
                elif left_wait:
                    worker_id = left_wait.pop()
                    heapq.heappush(on_bridge, (t + time[worker_id][0], worker_id, 1))
                    workers.remove(worker_id)

            if not on_bridge and (right_wait or left_wait or left_wait or workers):
                next_time = float('inf')
                if on_bridge:
                    next_time = min(next_time, on_bridge[0][0])
                t = max(t, next_time if next_time != float('inf') else t)

            while len(workers) < k and finished:
                worker_id = finished.pop()
                heapq.heappush(right_wait, (-time[worker_id][1] - time[worker_id][3], worker_id))
                workers.append(worker_id)
                workers.sort()

            t = on_bridge[0][0] if on_bridge else t

        return t