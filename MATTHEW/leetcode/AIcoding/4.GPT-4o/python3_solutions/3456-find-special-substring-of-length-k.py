class Solution:
    def specialSubstring(self, s: str, k: int) -> str:
        n = len(s)
        if n < k:
            return ""

        def is_special(substr):
            return len(set(substr)) == 1

        for i in range(n - k + 1):
            if is_special(s[i:i + k]):
                return s[i:i + k]

        return ""