class Solution:
    def countCompleteSubstrings(self, word: str, k: int) -> int:
        def count_k(s):
            res = 0
            for unique in range(1, 27):
                if unique * k > len(s):
                    break
                left = 0
                freq = [0] * 26
                for right in range(len(s)):
                    c = ord(s[right]) - ord('a')
                    freq[c] += 1
                    while freq[c] > k:
                        left_char = ord(s[left]) - ord('a')
                        freq[left_char] -= 1
                        left += 1
                    if right - left + 1 == unique * k:
                        valid = True
                        for i in range(26):
                            if freq[i] != 0 and freq[i] != k:
                                valid = False
                                break
                        if valid:
                            res += 1
            return res

        res = 0
        start = 0
        for i in range(1, len(word)):
            if abs(ord(word[i]) - ord(word[i-1])) > 2:
                res += count_k(word[start:i])
                start = i
        res += count_k(word[start:])
        return res