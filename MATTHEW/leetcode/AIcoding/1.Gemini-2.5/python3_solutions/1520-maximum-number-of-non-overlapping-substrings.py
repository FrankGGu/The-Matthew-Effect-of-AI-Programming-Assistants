class Solution:
    def maxNumOfSubstrings(self, s: str) -> list[str]:
        n = len(s)

        first = {}
        last = {}
        for i, char in enumerate(s):
            if char not in first:
                first[char] = i
            last[char] = i

        # Step 1: Precompute all valid candidate substrings.
        # A substring s[i:j+1] is valid if:
        # 1. For its starting character s[i], all occurrences of s[i] are within s[i:j+1].
        # 2. For any character c in s[i:j+1], all occurrences of c are within s[i:j+1].
        # This implies that for a valid substring s[start:end+1]:
        #   - first[s[start]] == start
        #   - For any k in [start, end]: first[s[k]] >= start and last[s[k]] <= end

        # We will find for each possible starting index `i`, the smallest `end` index `j`
        # such that `s[i:j+1]` forms a valid substring.
        # This is done in O(N) by using a sliding window approach.

        # `rightmost_valid_end[i]` stores the smallest end index `j` for a valid substring starting at `i`.
        # If `i` cannot be a valid start, `rightmost_valid_end[i]` is -1.

        # Initialize `rightmost_valid_end` array.
        rightmost_valid_end = [-1] * n

        j = 0 # Pointer for the end of the current segment being considered
        for i in range(n): # `i` is the potential start of a substring
            # `j` should always be at least `i`
            j = max(j, i)

            # `max_end_for_current_segment` tracks the rightmost occurrence of any character
            # encountered in `s[i:j+1]`.
            # `min_start_for_current_segment` tracks the leftmost occurrence of any character
            # encountered in `s[i:j+1]`.

            # Initialize for the segment starting at `i`
            max_end_for_current_segment = last[s[i]]
            min_start_for_current_segment = first[s[i]]

            # Expand `j` until `j` reaches `max_end_for_current_segment`
            while j <= max_end_for_current_segment:
                min_start_for_current_segment = min(min_start_for_current_segment, first[s[j]])
                max_end_for_current_segment = max(max_end_for_current_segment, last[s[j]])
                j += 1

            # After the loop, `[min_start_for_current_segment, max_end_for_current_segment]`
            # defines the minimal range that covers all characters in `s[i:max_end_for_current_segment+1]`
            # and all their occurrences.

            # If `min_start_for_current_segment == i`, it means all characters in the segment
            # `s[i:max_end_for_current_segment+1]` have their first occurrence at or after `i`.
            # And `i` is the first occurrence of `s[i]`.
            # So, `s[i:max_end_for_current_segment+1]` is a valid substring.
            if min_start_for_current_segment == i:
                rightmost_valid_end[i] = max_end_for_current_segment
            # If `min_start_for_current_segment < i`, it means some character `s[k]` in `s[i:max_end_for_current_segment+1]`
            # has its first occurrence before `i`. Thus, `i` cannot be the start of a valid substring.
            # In this case, `rightmost_valid_end[i]` remains -1.

        # Step 2: Filter and sort the valid substrings.
        # Collect all (start, end) pairs where `rightmost_valid_end[i]` is not -1.
        candidate_intervals = []
        for i in range(n):
            if rightmost_valid_end[i] != -1:
                candidate_intervals.append((i, rightmost_valid_end[i]))

        # Sort intervals by their end points, then by their start points (or length, for tie-breaking).
        # This is crucial for the greedy selection.
        candidate_intervals.sort(key=lambda x: (x[1], x[0]))

        # Step 3: Greedily select the maximum number of non-overlapping substrings.
        result = []
        prev_end = -1 # Tracks the end of the last selected substring

        for start, end in candidate_intervals:
            # If the current substring starts after the previously selected one ends,
            # it's non-overlapping and can be selected.
            if start > prev_end:
                result.append(s[start : end + 1])
                prev_end = end

        return result