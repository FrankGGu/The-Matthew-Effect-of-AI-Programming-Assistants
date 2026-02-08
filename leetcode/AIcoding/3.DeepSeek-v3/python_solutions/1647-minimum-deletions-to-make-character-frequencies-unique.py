class Solution:
    def minDeletions(self, s: str) -> int:
        freq = {}
        for char in s:
            freq[char] = freq.get(char, 0) + 1

        seen = set()
        deletions = 0

        for count in sorted(freq.values(), reverse=True):
            while count > 0 and count in seen:
                count -= 1
                deletions += 1
            seen.add(count)

        return deletions