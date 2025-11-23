class Solution:
    def maxPartitionsAfterOperations(self, s: str) -> int:
        n = len(s)

        # next_break_0[i] stores the index j such that s[i...j-1] is the first valid partition starting at i
        # (i.e., s[j] is the first character that causes a duplicate in s[i...j])
        next_break_0 = [0] * n
        last_seen = {}
        j = 0
        for i in range(n):
            while j < n:
                if s[j] in last_seen:
                    break
                last_seen[s[j]] = j
                j += 1
            next_break_0[i] = j
            del last_seen[s[i]]

        # next_break_1[i] stores the index j such that s[i...j-1] is the longest segment starting at i
        # that can be made valid with at most one operation.
        # This means s[i...j-1] contains at most one character that appears more than once.
        next_break_1 = [0] * n
        counts = [0] * 26
        num_dups_chars = 0  # Number of distinct characters that appear more than once
        j = 0
        for i in range(n):
            while j < n:
                char_idx = ord(s[j]) - ord('a')
                counts[char_idx] += 1
                if counts[char_idx] == 2:  # This character just became a duplicate
                    num_dups_chars += 1

                if num_dups_chars > 1: # s[i...j] has more than one distinct duplicated character
                    break
                j += 1
            next_break_1[i] = j

            char_idx = ord(s[i]) - ord('a')
            counts[char_idx] -= 1
            if counts[char_idx] == 1:  # This character just stopped being a duplicate
                num_dups_chars -= 1

        # dp[i][0]: max partitions for suffix s[i:] using 0 operations
        # dp[i][1]: max partitions for suffix s[i:] using 1 operation
        dp = [[0, 0] for _ in range(n + 1)]

        for i in range(n - 1, -1, -1):
            # Calculate dp[i][0]
            # The current partition s[i...next_break_0[i]-1] uses 0 operations.
            # Then we add partitions from s[next_break_0[i]:] using 0 operations.
            dp[i][0] = 1 + dp[next_break_0[i]][0]

            # Calculate dp[i][1]
            # Option 1: Use 0 operations for the current partition s[i...next_break_0[i]-1],
            #           and 1 operation for the remaining suffix s[next_break_0[i]:].
            dp[i][1] = 1 + dp[next_break_0[i]][1]

            # Option 2: Use 1 operation for the current partition s[i...next_break_1[i]-1],
            #           and 0 operations for the remaining suffix s[next_break_1[i]:].
            #           This segment s[i...next_break_1[i]-1] is the longest possible
            #           that can be made valid with 1 operation.
            dp[i][1] = max(dp[i][1], 1 + dp[next_break_1[i]][0])

        return dp[0][1]