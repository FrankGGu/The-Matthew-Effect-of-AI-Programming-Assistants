class Solution:
    def minimumString(self, s: str) -> str:
        def remove_substring(s, sub):
            while sub in s:
                s = s.replace(sub, "")
            return s

        candidates = [s, s[::-1]]
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                candidates.append(remove_substring(s, s[i:j]))

        return min(candidates, key=lambda x: (len(x), x))