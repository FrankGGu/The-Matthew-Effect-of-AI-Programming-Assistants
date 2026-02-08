class Solution:
    def distinctEchoSubstrings(self, text: str) -> int:
        n = len(text)
        seen = set()
        for length in range(1, n // 2 + 1):
            hashes = {}
            base = 256
            mod = 2**63 - 1
            h = 0
            for i in range(length):
                h = (h * base + ord(text[i])) % mod
            hashes[h] = 1

            for i in range(length, n):
                h = (h * base + ord(text[i]) - ord(text[i - length]) * (base ** length)) % mod
                if h in hashes:
                    seen.add(text[i - length + 1: i + 1])
                hashes[h] = hashes.get(h, 0) + 1

        return len(seen)