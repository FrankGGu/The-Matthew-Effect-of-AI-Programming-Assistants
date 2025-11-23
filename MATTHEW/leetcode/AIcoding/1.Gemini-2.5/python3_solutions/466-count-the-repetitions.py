class Solution:
    def getMaxRepetitions(self, s1: str, n1: int, s2: str, n2: int) -> int:
        len_s1 = len(s1)
        len_s2 = len(s2)

        if len_s1 == 0 or len_s2 == 0:
            return 0

        s2_ptr_current = 0
        total_s2_matched = 0

        # s2_ptr_map: maps s2_ptr_current (state) to (s1_rep_idx, total_s2_matched_at_that_s1_rep)
        # s1_rep_idx is the 0-indexed repetition of s1 that just finished.
        s2_ptr_map = {}

        # s2_matched_history: stores total_s2_matched after each s1 repetition.
        # s2_matched_history[k] stores total_s2_matched after (k+1) repetitions of s1.
        s2_matched_history = []

        for i in range(n1):
            s2_matched_in_this_s1_rep = 0
            for char_s1 in s1:
                if char_s1 == s2[s2_ptr_current]:
                    s2_ptr_current += 1
                    if s2_ptr_current == len_s2:
                        s2_ptr_current = 0
                        s2_matched_in_this_s1_rep += 1

            total_s2_matched += s2_matched_in_this_s1_rep

            # Check for cycle
            if s2_ptr_current in s2_ptr_map:
                prev_s1_rep_idx, prev_total_s2_matched = s2_ptr_map[s2_ptr_current]

                cycle_len_s1 = i - prev_s1_rep_idx
                cycle_s2_matched = total_s2_matched - prev_total_s2_matched

                # Number of s1 repetitions remaining after the current one (i)
                remaining_s1_reps_to_process = n1 - 1 - i

                # Add full cycles
                num_cycles = remaining_s1_reps_to_process // cycle_len_s1
                total_s2_matched += num_cycles * cycle_s2_matched

                # Add remaining partial cycle
                remainder_s1_reps = remaining_s1_reps_to_process % cycle_len_s1

                # Process the remaining s1 repetitions using the precomputed history
                # The history stores cumulative sums.
                # To get the count for a specific s1 repetition in the cycle:
                # s2_matched_history[prev_s1_rep_idx + j + 1] - s2_matched_history[prev_s1_rep_idx + j]
                for j in range(remainder_s1_reps):
                    total_s2_matched += (s2_matched_history[prev_s1_rep_idx + j + 1] - s2_matched_history[prev_s1_rep_idx + j])

                return total_s2_matched // n2

            # Store current state for cycle detection
            s2_ptr_map[s2_ptr_current] = (i, total_s2_matched)
            s2_matched_history.append(total_s2_matched)

        # If no cycle was detected within n1 iterations (or n1 was small)
        return total_s2_matched // n2