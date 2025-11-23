import heapq

class Solution:
    def minTime(self, time: list[int], m: int, k: int) -> int:
        n = len(time)

        if k >= n:
            return 0

        low = 0
        high = sum(time)
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if self._check(mid, time, m, k):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans

    def _check(self, max_daily_time: int, time: list[int], m: int, k: int) -> bool:
        n = len(time)

        if max_daily_time == 0:
            return k >= n

        days_count = 1
        total_skips_used = 0
        current_idx = 0

        while current_idx < n:
            if days_count > m:
                return False

            current_day_sum = 0
            current_day_heap = [] 
            day_skip_used = False 

            while current_idx < n:
                t = time[current_idx]

                if current_day_sum + t <= max_daily_time:
                    current_day_sum += t
                    heapq.heappush(current_day_heap, -t)
                    current_idx += 1
                else:
                    max_val_to_consider_skip = t
                    if current_day_heap:
                        max_val_to_consider_skip = max(max_val_to_consider_skip, -current_day_heap[0])

                    if (not day_skip_used and total_skips_used < k and
                            current_day_sum + t - max_val_to_consider_skip <= max_daily_time):

                        total_skips_used += 1
                        day_skip_used = True
                        current_day_sum = current_day_sum + t - max_val_to_consider_skip

                        if max_val_to_consider_skip == t:
                            pass
                        else:
                            heapq.heappop(current_day_heap)
                            heapq.heappush(current_day_heap, -t)
                        current_idx += 1
                    else:
                        break 

            if current_idx < n:
                days_count += 1

        return days_count <= m