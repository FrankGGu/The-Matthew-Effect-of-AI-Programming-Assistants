class Solution:
    def longestNiceSubstring(self, s: str) -> str:
        if not s:
            return ""

        longest = ""
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                sub = s[i:j]
                is_nice = True
                for char in sub:
                    if char.islower():
                        if char.upper() not in sub:
                            is_nice = False
                            break
                    else:
                        if char.lower() not in sub:
                            is_nice = False
                            break
                if is_nice and len(sub) > len(longest):
                    longest = sub

        return longest