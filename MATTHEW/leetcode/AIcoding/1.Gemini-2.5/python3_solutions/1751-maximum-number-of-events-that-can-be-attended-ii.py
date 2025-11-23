import bisect

class Solution:
    def maxValue(self, events: list[list[int]], k: int) -> int:
        events.sort()
        n = len(events)

        # dp[i] will store the maximum value obtained by attending (j-1) events 
        # from events[i:] (events from index i to n-1).
        # This array is updated in each iteration for 'j' (number of events attended).
        dp = [0] * (n + 1) 

        # Extract start times for efficient binary search.
        # This list will be used to find the next non-overlapping event.
        start_times = [event[0] for event in events]

        # Iterate for the number of events allowed, from 1 up to k.
        for j in range(1, k + 1): 
            # next_dp will store the maximum values for attending 'j' events.
            # It's initialized for the current 'j' and will become 'dp' for 'j+1'.
            next_dp = [0] * (n + 1) 

            # Iterate through events from the last one to the first one.
            # This allows us to use previously computed values (dp[i+1] and dp[next_event_idx]).
            for i in range(n - 1, -1, -1): 
                s, e, v = events[i]

                # Option 1: Do not attend the current event (events[i]).
                # The maximum value is the same as attending 'j' events from events[i+1:].
                next_dp[i] = next_dp[i+1]

                # Option 2: Attend the current event (events[i]).
                # We need to find the next event that starts strictly after events[i] ends.
                # bisect_left finds the index of the first event that starts at or after 'e + 1'.
                next_event_idx = bisect.bisect_left(start_times, e + 1)

                # The value obtained is 'v' (from current event) plus the maximum value 
                # from attending (j-1) events from 'next_event_idx' onwards.
                # dp[next_event_idx] holds the max value for (j-1) events from events[next_event_idx:].
                next_dp[i] = max(next_dp[i], v + dp[next_event_idx])

            # After computing all values for 'j' events, update 'dp' to 'next_dp'
            # for the next iteration (j+1).
            dp = next_dp 

        # The final answer is the maximum value attending 'k' events from events[0:]
        # which is stored in dp[0] after 'k' iterations.
        return dp[0]