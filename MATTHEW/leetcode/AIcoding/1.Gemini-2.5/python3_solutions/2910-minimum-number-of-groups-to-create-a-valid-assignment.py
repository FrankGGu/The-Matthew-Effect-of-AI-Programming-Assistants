import collections

class Solution:
    def minGroupsForValidAssignment(self, nums: list[int]) -> int:
        counts = collections.Counter(nums)
        freqs = list(counts.values())

        min_freq = min(freqs)

        min_total_groups = float('inf')

        # 's' represents the base size for groups (groups will have size 's' or 's+1').
        # 's' must be a positive integer.
        # If 's' is greater than any frequency 'c', then 'c // s' would be 0.
        # However, '(c + s) // (s + 1)' would be at least 1 (since c >= 1),
        # making the condition (c + s) // (s + 1) <= c // s false.
        # Therefore, 's' must be less than or equal to the minimum frequency (min_freq).
        # So, 's' ranges from 1 to min_freq.
        for s in range(1, min_freq + 1):
            current_total_groups = 0
            is_s_valid = True
            for c in freqs:
                # For a given count 'c' and base group size 's', we need to check if 'c'
                # can be split into groups of size 's' or 's+1'.
                # Let 'k' be the total number of groups for 'c'.
                # Let 'a' be the number of groups of size 's+1' and 'b' be the number of groups of size 's'.
                # Then c = a * (s+1) + b * s.
                # We want to minimize k = a + b.
                # Substituting b = k - a: c = a * (s+1) + (k - a) * s = a * s + a + k * s - a * s = k * s + a.
                # So, a = c - k * s.
                # We also know 0 <= a <= k.
                # From 0 <= a => k * s <= c => k <= c // s.
                # From a <= k => c - k * s <= k => c <= k * (s+1) => k >= (c + s) // (s+1) (using ceil division).
                # Thus, for a valid split, there must exist a 'k' such that (c + s) // (s+1) <= k <= c // s.
                # To minimize 'k', we pick k = (c + s) // (s+1).
                # The condition for a valid split is that this minimum 'k' must be <= c // s.
                # So, (c + s) // (s+1) <= c // s.
                # This inequality is equivalent to the condition c % s <= c // s.
                # If c % s > c // s, then it's impossible to form groups of size 's' or 's+1' for this count 'c'.

                if c % s > c // s:
                    is_s_valid = False
                    break

                # If valid, calculate the minimum number of groups for this count 'c'
                # which is ceil(c / (s+1))
                k_min_c = (c + s) // (s + 1)
                current_total_groups += k_min_c

            if is_s_valid:
                min_total_groups = min(min_total_groups, current_total_groups)

        return min_total_groups