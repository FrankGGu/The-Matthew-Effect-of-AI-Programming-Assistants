class Solution:
    def lastNonEmptyString(self, s: str) -> str:
        counts = {}
        for i, char in enumerate(s):
            counts[char] = i

        max_val = max(counts.values())

        res = ""
        for char, val in counts.items():
            if val == max_val:
                res += char

        return "".join(sorted(res))