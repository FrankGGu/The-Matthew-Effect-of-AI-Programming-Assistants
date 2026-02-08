from collections import defaultdict

class Solution:
    def getTriggerTime(self, actions: list[list[int]], queries: list[list[int]]) -> list[int]:
        # Step 1: Aggregate stat changes for each unique time point.
        # time_to_stats_delta maps time -> [exp_delta, gold_delta, rep_delta]
        time_to_stats_delta = defaultdict(lambda: [0, 0, 0])
        for time, type, value in actions:
            time_to_stats_delta[time][type] += value

        # Step 2: Create a list of cumulative states.
        # Each entry is (time, total_exp, total_gold, total_rep) after all actions at that time.
        # Start with an initial state at time 0 with zero stats.
        cumulative_states = [(0, 0, 0, 0)]
        current_exp, current_gold, current_rep = 0, 0, 0

        # Get unique action times and sort them.
        sorted_times = sorted(time_to_stats_delta.keys())

        for t in sorted_times:
            exp_delta, gold_delta, rep_delta = time_to_stats_delta[t]
            current_exp += exp_delta
            current_gold += gold_delta
            current_rep += rep_delta
            # Append the state *after* all actions at time `t` have been processed.
            cumulative_states.append((t, current_exp, current_gold, current_rep))

        # Step 3: Process each query using binary search on cumulative_states.
        results = [-1] * len(queries)

        # Store queries with their original indices to place results correctly.
        indexed_queries = []
        for i, query in enumerate(queries):
            indexed_queries.append((query[0], query[1], query[2], i)) # (q_exp, q_gold, q_rep, original_index)

        for q_exp, q_gold, q_rep, original_idx in indexed_queries:
            low = 0
            high = len(cumulative_states) - 1
            ans_time = -1

            while low <= high:
                mid = low + (high - low) // 2
                t_mid, exp_mid, gold_mid, rep_mid = cumulative_states[mid]

                # Check if the current state satisfies all query conditions.
                if exp_mid >= q_exp and gold_mid >= q_gold and rep_mid >= q_rep:
                    ans_time = t_mid # This time satisfies the query
                    high = mid - 1   # Try to find an even earlier time
                else:
                    low = mid + 1    # Current time is too early, need more stats, go to a later time

            results[original_idx] = ans_time

        return results