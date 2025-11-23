class Solution:
    def countGoodSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        if n < 3:
            return 0

        count = 0
        freq = {}

        for i in range(n):
            if i >= 3:
                left_char = s[i - 3]
                freq[left_char] -= 1
                if freq[left_char] == 0:
                    del freq[left_char]
            freq[s[i]] = freq.get(s[i], 0) + 1

            if i >= 2:
                if len(freq) == k:
                    count += 1

        return count