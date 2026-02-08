class Solution:
    def minimumDeletions(self, s: str) -> int:
        count_a = 0
        deletions = 0

        for char in s:
            if char == 'a':
                count_a += 1
            else:
                deletions += 1
                if count_a > 0:
                    count_a -= 1

        return deletions + count_a