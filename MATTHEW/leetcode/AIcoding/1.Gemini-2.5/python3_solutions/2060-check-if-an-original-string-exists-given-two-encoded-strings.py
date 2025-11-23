import functools

class Solution:
    def possiblyEquals(self, s1: str, s2: str) -> bool:

        @functools.lru_cache(None)
        def dp(i, j, diff):
            # Base case: both strings exhausted
            if i == len(s1) and j == len(s2):
                return diff == 0

            # Option 1: s1 is ahead (diff > 0)
            # We must consume characters from s2 to reduce diff.
            if diff > 0:
                # If s2 is exhausted, s1 cannot be matched.
                if j == len(s2):
                    return False

                # Try consuming a letter from s2
                if s2[j].isalpha():
                    if dp(i, j + 1, diff - 1):
                        return True
                # Try consuming a number from s2
                else: # s2[j] is a digit
                    num = 0
                    for k in range(j, min(j + 3, len(s2))): # Numbers can be 1, 2, or 3 digits
                        if s2[k].isdigit():
                            num = num * 10 + int(s2[k])
                            if dp(i, k + 1, diff - num):
                                return True
                        else:
                            break
                return False

            # Option 2: s2 is ahead (diff < 0)
            # We must consume characters from s1 to increase diff.
            elif diff < 0:
                # If s1 is exhausted, s2 cannot be matched.
                if i == len(s1):
                    return False

                # Try consuming a letter from s1
                if s1[i].isalpha():
                    if dp(i + 1, j, diff + 1):
                        return True
                # Try consuming a number from s1
                else: # s1[i] is a digit
                    num = 0
                    for k in range(i, min(i + 3, len(s1))):
                        if s1[k].isdigit():
                            num = num * 10 + int(s1[k])
                            if dp(k + 1, j, diff + num):
                                return True
                        else:
                            break
                return False

            # Option 3: diff == 0 (aligned)
            else: # diff == 0
                # Try to consume from s1
                if i < len(s1):
                    # If s1[i] is a letter
                    if s1[i].isalpha():
                        # If s2[j] is also a letter and they match, consume both.
                        if j < len(s2) and s2[j].isalpha() and s1[i] == s2[j]:
                            if dp(i + 1, j + 1, 0):
                                return True
                    # If s1[i] is a digit, parse number and make s1 ahead.
                    else:
                        num = 0
                        for k in range(i, min(i + 3, len(s1))):
                            if s1[k].isdigit():
                                num = num * 10 + int(s1[k])
                                if dp(k + 1, j, num): # s1 is now ahead by num
                                    return True
                            else:
                                break

                # Try to consume from s2 (if no match found yet from s1's options)
                # This branch only applies if s2[j] is a digit, making s2 ahead.
                if j < len(s2) and s2[j].isdigit():
                    num = 0
                    for k in range(j, min(j + 3, len(s2))):
                        if s2[k].isdigit():
                            num = num * 10 + int(s2[k])
                            if dp(i, k + 1, -num): # s2 is now ahead by num
                                return True
                        else:
                            break

                return False # No valid path found from diff == 0 state

        return dp(0, 0, 0)