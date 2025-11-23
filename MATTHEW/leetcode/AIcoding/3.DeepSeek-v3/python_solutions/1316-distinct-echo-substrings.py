class Solution:
    def distinctEchoSubstrings(self, text: str) -> int:
        n = len(text)
        seen = set()
        for l in range(1, n // 2 + 1):
            count = 0
            for i in range(n - l):
                if text[i] == text[i + l]:
                    count += 1
                else:
                    count = 0
                if count == l:
                    seen.add(text[i - l + 1 : i + 1])
                    count -= 1
        return len(seen)