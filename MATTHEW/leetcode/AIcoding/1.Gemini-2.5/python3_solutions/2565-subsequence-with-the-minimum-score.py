import collections

class Solution:
    def minimumScore(self, s: str, t: str) -> int:
        n = len(s)
        m = len(t)

        # prefix_s_indices[i] stores the smallest index in s such that s[prefix_s_indices[i]] == t[i]
        # and t[0...i] is a subsequence of s[0...prefix_s_indices[i]].
        prefix_s_indices = [-1] * m
        curr_s_ptr = -1
        for i in range(m):
            curr_s_ptr = s.find(t[i], curr_s_ptr + 1)
            if curr_s_ptr == -1:
                # If we can't match t[i], then no further prefix can be matched.
                # Fill the rest with -1 or break.
                break
            prefix_s_indices[i] = curr_s_ptr

        # suffix_s_indices[i] stores the largest index in s such that s[suffix_s_indices[i]] == t[i]
        # and t[i...m-1] is a subsequence of s[suffix_s_indices[i]...n-1].
        suffix_s_indices = [-1] * m
        curr_s_ptr = n
        for i in range(m - 1, -1, -1):
            curr_s_ptr = s.rfind(t[i], 0, curr_s_ptr)
            if curr_s_ptr == -1:
                # If we can't match t[i], then no further suffix can be matched.
                # Fill the rest with -1 or break.
                break
            suffix_s_indices[i] = curr_s_ptr

        min_removed_len = float('inf')

        # Case 1: The subsequence is a prefix of t, i.e., t[0...i].
        # The number of removed characters from t is (m-1) - i.
        # We want to minimize this, so maximize i.
        # The score is (m-1) - i.
        # No, the score is the length of the removed part.
        # If `t[0...i]` is the subsequence, we removed `t[i+1...m-1]`.
        # The length of removed part is `m - (i + 1)`.
        for i in range(m):
            if prefix_s_indices[i] != -1:
                min_removed_len = min(min_removed_len, m - (i + 1))
            else:
                break

        # Case 2: The subsequence is a suffix of t, i.e., t[i...m-1].
        # The number of removed characters from t is i.
        # We want to minimize this, so minimize i.
        # The score is i.
        for i in range(m):
            if suffix_s_indices[i] != -1:
                min_removed_len = min(min_removed_len, i)
            else:
                # If suffix_s_indices[i] is -1, it means t[i...m-1] cannot be formed.
                # All t[j...m-1] for j < i also cannot be formed.
                # So we can stop.
                # No, this is not true. suffix_s_indices[i] might be -1, but suffix_s_indices[i+1] might be valid.
                # The loop correctly processes from left to right.
                pass

        # Case 3: The subsequence is formed by t[0...p1] and t[p2...m-1], where p1 < p2.
        # The removed part is t[p1+1 ... p2-1].
        # We want to minimize the length of this removed part: (p2 - 1) - (p1 + 1) + 1 = p2 - p1 - 1.
        # Iterate p1 from -1 to m-1 (inclusive).
        # p1 = -1 means empty prefix.
        # p1 = m-1 means full prefix t[0...m-1].
        # p2 is the start index of the suffix.
        # p2 must be > p1.

        # Initialize p2 to m-1 (start of the rightmost possible suffix)
        p2 = m - 1
        for p1 in range(-1, m): # p1 is the last index of prefix t[0...p1]
            s_idx_for_prefix = -1
            if p1 >= 0:
                if prefix_s_indices[p1] == -1:
                    # If prefix t[0...p1] cannot be formed, no longer prefixes can be formed.
                    break
                s_idx_for_prefix = prefix_s_indices[p1]

            # Move p2 leftwards as long as it's not valid or too far right.
            # We need suffix_s_indices[p2] > s_idx_for_prefix.
            # And p2 must be at least p1 + 1.
            while p2 > p1 and (suffix_s_indices[p2] == -1 or suffix_s_indices[p2] <= s_idx_for_prefix):
                p2 -= 1

            # Now, if p2 > p1, we have a valid combination of prefix and suffix.
            # The removed part is t[p1+1 ... p2-1]. Its length is p2 - (p1 + 1).
            if p2 > p1:
                min_removed_len = min(min_removed_len, p2 - (p1 + 1))
            else:
                # If p2 <= p1, it means no valid suffix can be found after this prefix.
                # This `i` (p1) is the last possible prefix.
                # The loop will break anyway.
                pass

        return min_removed_len