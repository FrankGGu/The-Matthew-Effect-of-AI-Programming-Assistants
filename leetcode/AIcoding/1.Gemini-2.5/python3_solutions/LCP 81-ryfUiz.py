import functools

class Solution:
    def numberOfPowerfulInt(self, start: int, finish: int, limit: int, s: str) -> int:
        self.limit = limit
        self.s = s
        self.s_len = len(s)

        # Pre-check if 's' itself is valid based on limit and leading zeros
        # If s has leading zeros and length > 1 (e.g., "01"), it cannot be a suffix
        # of a powerful integer's string representation, unless the number itself is 0,
        # but 0 is only powerful if s="0".
        if self.s_len > 1 and self.s[0] == '0':
            # Example: s="01". A number like "101" ends with "1", not "01".
            # "01" as a number is just "1". It does not end with "01".
            # The only exception is if s="0", which is handled by the main logic.
            return 0

        for char_s in self.s:
            if int(char_s) > self.limit:
                return 0

        def count_powerful(num_str_val: str) -> int:
            n = len(num_str_val)

            @functools.lru_cache(None)
            def dfs(idx: int, tight: bool, is_started: bool) -> int:
                # idx: current digit position we are trying to fill (from left, 0 to n-1)
                # tight: True if we are restricted by the digits of num_str_val
                # is_started: True if we have placed at least one non-zero digit,
                #             or we are forced to place a digit for 's' (i.e., not in leading zeros state)

                if idx == n:
                    # If we reached the end:
                    # If is_started is True, we have successfully formed a non-zero number
                    # that satisfied all conditions, so it's a powerful integer.
                    # If is_started is False, it means the number formed is 0.
                    # This is only a powerful integer if s is "0".
                    return 1 if is_started else (1 if self.s == "0" else 0)

                ans = 0
                upper_bound = int(num_str_val[idx]) if tight else 9

                for digit in range(upper_bound + 1):
                    # Check digit limit
                    if digit > self.limit:
                        continue

                    # If we are currently in the leading zeros state and place a zero
                    if not is_started and digit == 0:
                        ans += dfs(idx + 1, tight and (digit == upper_bound), False)
                    # If we are placing a non-zero digit, or a zero after a non-zero digit (i.e., not in leading zeros state)
                    else:
                        # Check suffix constraint
                        # The suffix 's' must start at position (n - s_len) in the n-digit padded number.
                        # If the current index 'idx' is within the suffix part, the digit must match 's'.
                        if idx >= n - self.s_len:
                            if digit != int(self.s[idx - (n - self.s_len)]):
                                continue

                        ans += dfs(idx + 1, tight and (digit == upper_bound), True)

                return ans

            # The dfs function counts powerful integers 'x' such that:
            # 1. 'x' has 'n' digits (padded with leading zeros if necessary)
            # 2. 'x' <= num_str_val
            # 3. 'x' satisfies digit limit and suffix 's' constraints.
            # This correctly handles numbers of shorter effective length (e.g., '12' when num_str_val is '1000' is counted as '0012').
            return dfs(0, True, False)

        # Calculate count for numbers up to 'finish'
        count_finish = count_powerful(str(finish))

        # Calculate count for numbers up to 'start - 1'
        count_start_minus_1 = count_powerful(str(start - 1))

        return count_finish - count_start_minus_1