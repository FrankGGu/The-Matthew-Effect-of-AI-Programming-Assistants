import collections
import math

class Solution:
    def minFinishTime(self, tires: list[list[int]], changeTime: int, numLaps: int) -> int:
        # MAX_TIME_THRESHOLD serves as an upper bound for the time taken by any single tire
        # for a sequence of laps. If a tire's cumulative time exceeds this, it's likely
        # suboptimal and we can stop considering it for more laps.
        # A loose upper bound for dp[numLaps] is numLaps * (min_fi + changeTime).
        # With numLaps=10^5, min_fi=1, changeTime=10^9, this is approx 10^14.
        # Using 2 * 10^14 provides a safe margin.
        MAX_TIME_THRESHOLD = 2 * 10**14 

        # min_time_single_tire_k_laps[k] stores the minimum time to complete 'k' laps
        # using a *single* new tire (without considering 'changeTime').
        min_time_single_tire_k_laps = [float('inf')] * (numLaps + 1)

        # min_fi_for_ri_1 stores the minimum 'fi' among all tires with 'ri = 1'.
        # This is used for an optimization for long sequences of laps.
        min_fi_for_ri_1 = float('inf')

        # Precompute min_time_single_tire_k_laps for all tires.
        for fi, ri in tires:
            if ri == 1:
                min_fi_for_ri_1 = min(min_fi_for_ri_1, fi)
            else:
                current_lap_time = fi
                total_time_for_laps = fi

                # For k=1 lap
                min_time_single_tire_k_laps[1] = min(min_time_single_tire_k_laps[1], total_time_for_laps)

                # For k > 1 laps, calculate cumulative time and update.
                for k in range(2, numLaps + 1):
                    # Pruning: If the time for the next lap (current_lap_time * ri)
                    # would exceed the threshold, or if adding it to total_time_for_laps
                    # would exceed the threshold, this tire is too expensive for more laps.
                    if current_lap_time > MAX_TIME_THRESHOLD / ri:
                        break

                    current_lap_time *= ri

                    if total_time_for_laps > MAX_TIME_THRESHOLD - current_lap_time:
                        break

                    total_time_for_laps += current_lap_time
                    min_time_single_tire_k_laps[k] = min(min_time_single_tire_k_laps[k], total_time_for_laps)

        # If there are tires with ri = 1, their cost for k laps is fi * k.
        # Update min_time_single_tire_k_laps with these values.
        if min_fi_for_ri_1 != float('inf'):
            for k in range(1, numLaps + 1):
                min_time_single_tire_k_laps[k] = min(min_time_single_tire_k_laps[k], min_fi_for_ri_1 * k)

        # dp[i] is the minimum time to finish 'i' laps.
        dp = [float('inf')] * (numLaps + 1)
        dp[0] = 0

        # MAX_K_FOR_RI_GT_1 is an empirically chosen constant. Tires with ri > 1
        # typically become very expensive after a small number of laps (e.g., ~60 laps for ri=2).
        # This constant helps bound the inner loop for the DP.
        MAX_K_FOR_RI_GT_1 = 60 

        # Deque for optimizing the DP transition for tires with ri = 1.
        # This is a form of Convex Hull Trick / Sliding Window Minimum.
        # We want to find min_{0 <= j < i} (dp[j] - min_fi_for_ri_1 * j) + (changeTime + min_fi_for_ri_1) * i.
        # The deque stores indices 'j' that minimize `dp[j] - min_fi_for_ri_1 * j`.
        dq = collections.deque()
        C_ri1_term = float('inf') # Represents (changeTime + min_fi_for_ri_1)

        if min_fi_for_ri_1 != float('inf'):
            C_ri1_term = changeTime + min_fi_for_ri_1
            # Initialize deque with index 0 (for dp[0] - min_fi_for_ri_1 * 0 = 0).
            dq.append(0) 

        for i in range(1, numLaps + 1):
            # Option 1: The last segment of 'k' laps is completed using a tire
            # (either ri > 1 or ri = 1 for small 'k').
            # Initialize dp[i] with the cost of completing all 'i' laps with a single new tire
            # (no 'changeTime' needed if it's the first/only tire).
            dp[i] = min_time_single_tire_k_laps[i]

            # Consider breaking the 'i' laps into 'i-k' laps and then 'k' laps.
            # The last 'k' laps are done with a new tire, so 'changeTime' is added.
            # 'k' ranges from 1 up to MAX_K_FOR_RI_GT_1.
            # We only consider k < i here, as k=i is handled by the initialization.
            for k in range(1, min(i, MAX_K_FOR_RI_GT_1 + 1)):
                if min_time_single_tire_k_laps[k] != float('inf'):
                    cost = dp[i-k] + changeTime + min_time_single_tire_k_laps[k]
                    dp[i] = min(dp[i], cost)

            # Option 2: The last segment of 'k' laps uses the optimal ri=1 tire,
            # and 'k' can be larger than MAX_K_FOR_RI_GT_1.
            # This is where the deque optimization for `dp[j] - min_fi_for_ri_1 * j` is applied.
            if C_ri1_term != float('inf'):
                # Remove indices 'j' from the front of the deque that are too old.
                # 'j' must be such that k = i-j > MAX_K_FOR_RI_GT_1.
                # This means j <= i - (MAX_K_FOR_RI_GT_1 + 1).
                # So, if dq[0] < i - MAX_K_FOR_RI_GT_1, it's too old.
                while dq and dq[0] < i - MAX_K_FOR_RI_GT_1:
                    dq.popleft()

                # If the deque is not empty, use the best 'j' (at dq[0]) to update dp[i].
                if dq:
                    j_min = dq[0]
                    potential_cost = (dp[j_min] - min_fi_for_ri_1 * j_min) + C_ri1_term * i
                    dp[i] = min(dp[i], potential_cost)

                # Add the current index 'i' to the deque, maintaining its monotonic property.
                # The value associated with index 'i' is `dp[i] - min_fi_for_ri_1 * i`.
                current_val_for_dq = dp[i] - min_fi_for_ri_1 * i
                while dq and (dp[dq[-1]] - min_fi_for_ri_1 * dq[-1]) >= current_val_for_dq:
                    dq.pop()
                dq.append(i)

        return dp[numLaps]