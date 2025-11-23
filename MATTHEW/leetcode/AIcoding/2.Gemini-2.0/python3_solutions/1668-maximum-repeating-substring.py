class Solution:
    def maxRepeating(self, sequence: str, word: str) -> int:
        k = 0
        temp = word
        while temp in sequence:
            k += 1
            temp += word
        return k