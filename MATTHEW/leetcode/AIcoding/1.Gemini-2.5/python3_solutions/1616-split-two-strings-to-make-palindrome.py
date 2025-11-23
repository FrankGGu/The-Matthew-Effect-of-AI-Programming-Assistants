class Solution:
    def checkPalindromeFormation(self, a: str, b: str) -> bool:
        n = len(a)

        def is_palindrome(s: str, left: int, right: int) -> bool:
            while left < right:
                if s[left] != s[right]:
                    return False
                left += 1
                right -= 1
            return True

        # This function checks if a palindrome can be formed by taking a prefix from s1
        # and a suffix from s2. That is, s1[0...i-1] + s2[i...n-1] is a palindrome for some 'i'.
        # The logic is as follows:
        # 1. Find the longest common prefix of s1 and reversed suffix of s2.
        #    Let 'l' and 'r' be the pointers after this step.
        #    So, s1[0...l-1] matches s2[r+1...n-1] (reversed).
        # 2. At this point, the "outer" parts match. The "middle" parts are s1[l...r] and s2[l...r].
        #    For the combined string to be a palindrome, the entire middle section must be a palindrome.
        #    There are two ways this can happen:
        #    a) The middle part is entirely from s1: If s1[l...r] is a palindrome.
        #       This corresponds to a split where aprefix = s1[0...r] and bsuffix = s2[r+1...n-1].
        #       The combined string formed is s1[0...r] + s2[r+1...n-1].
        #       Since s1[0...l-1] matches s2[r+1...n-1] (reversed) and s1[l...r] is a palindrome,
        #       the entire combined string is a palindrome.
        #    b) The middle part is entirely from s2: If s2[l...r] is a palindrome.
        #       This corresponds to a split where aprefix = s1[0...l-1] and bsuffix = s2[l...n-1].
        #       The combined string formed is s1[0...l-1] + s2[l...n-1].
        #       Since s1[0...l-1] matches s2[r+1...n-1] (reversed) and s2[l...r] is a palindrome,
        #       the entire combined string is a palindrome.
        def check(s1: str, s2: str) -> bool:
            l, r = 0, n - 1
            while l < r and s1[l] == s2[r]:
                l += 1
                r -= 1

            # Check if either of the remaining middle segments is a palindrome
            return is_palindrome(s1, l, r) or is_palindrome(s2, l, r)

        # The problem asks if either (aprefix + bsuffix) or (bprefix + asuffix) can form a palindrome.
        # We call the 'check' function for both possibilities.
        return check(a, b) or check(b, a)