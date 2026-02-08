class Solution:
    def minDeletions(self, s: str) -> int:
        a_count = 0
        b_count = 0
        deletions = 0
        for char in s:
            if char == 'a':
                a_count += 1
            else:
                b_count += 1
                deletions = min(deletions + 1, a_count)
        return deletions