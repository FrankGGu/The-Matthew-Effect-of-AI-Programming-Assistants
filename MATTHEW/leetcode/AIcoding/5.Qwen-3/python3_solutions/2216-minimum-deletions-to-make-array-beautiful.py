class Solution:
    def minDeletions(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        used = set()
        deletions = 0

        for char in s:
            if count[char] in used:
                while count[char] > 0 and count[char] in used:
                    count[char] -= 1
                    deletions += 1
            if count[char] > 0:
                used.add(count[char])

        return deletions