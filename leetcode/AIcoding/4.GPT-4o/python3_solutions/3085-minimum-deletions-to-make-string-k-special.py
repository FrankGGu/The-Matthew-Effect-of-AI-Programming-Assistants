class Solution:
    def minimumDeletions(self, s: str, k: int) -> int:
        freq = [0] * 26
        for char in s:
            freq[ord(char) - ord('a')] += 1

        freq.sort(reverse=True)
        return sum(freq[k:]) if k < len(freq) else sum(freq)