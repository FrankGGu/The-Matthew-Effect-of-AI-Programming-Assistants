class Solution:
    def minTime(self, times: list[int]) -> int:
        times.sort()
        n = len(times)

        total_time = 0

        while n > 3:
            # Strategy 1:
            # 1. Two fastest (times[0], times[1]) cross. Time: times[1]. (Torch on far side)
            # 2. Fastest (times[0]) returns. Time: times[0]. (Torch on near side)
            # 3. Two slowest (times[n-1], times[n-2]) cross. Time: times[n-1]. (Torch on far side)
            # 4. Second fastest (times[1]) returns. Time: times[1]. (Torch on near side)
            # Total for this cycle: times[1] + times[0] + times[n-1] + times[1]
            cost1 = times[1] + times[0] + times[n-1] + times[1]

            # Strategy 2:
            # 1. Fastest (times[0]) and slowest (times[n-1]) cross. Time: times[n-1]. (Torch on far side)
            # 2. Fastest (times[0]) returns. Time: times[0]. (Torch on near side)
            # 3. Fastest (times[0]) and second slowest (times[n-2]) cross. Time: times[n-2]. (Torch on far side)
            # 4. Fastest (times[0]) returns. Time: times[0]. (Torch on near side)
            # Total for this cycle: times[n-1] + times[0] + times[n-2] + times[0]
            cost2 = times[n-1] + times[0] + times[n-2] + times[0]

            total_time += min(cost1, cost2)
            n -= 2 # Two slowest people are now permanently on the other side

        # Handle remaining 1, 2, or 3 people
        if n == 1:
            total_time += times[0]
        elif n == 2:
            total_time += times[1]
        elif n == 3:
            total_time += times[0] + times[1] + times[2]

        return total_time