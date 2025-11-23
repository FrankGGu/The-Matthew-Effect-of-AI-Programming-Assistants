class Solution:
    def secondsToRemoveOccurrences(self, s: str) -> int:
        num_ones = 0
        time = 0

        for char in s:
            if char == '1':
                num_ones += 1
            else:  # char == '0'
                if num_ones > 0:
                    # If a '0' is encountered and there are '1's to its left,
                    # this '0' needs to move left past those '1's, and those '1's need to move right.
                    # This increases the total time.
                    # The 'time' variable tracks the maximum time any '0' or '1' needs.
                    # 'time + 1' accounts for the current '0' moving one step left.
                    # 'num_ones' accounts for the '1's that need to move right.
                    # The '0' essentially "consumes" one '1' that it needs to pass.
                    time = max(time + 1, num_ones)
                    num_ones -= 1

        return time