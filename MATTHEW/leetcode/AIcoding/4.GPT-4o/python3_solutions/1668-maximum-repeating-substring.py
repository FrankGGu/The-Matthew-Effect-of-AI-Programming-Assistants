class Solution:
    def maxRepeating(self, sequence: str, word: str) -> int:
        count = 0
        while word * (count + 1) in sequence:
            count += 1
        return count