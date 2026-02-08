class Solution:
    def findTheDifference(self, s: str, t: str) -> str:
        xor_sum = 0
        for char_s in s:
            xor_sum ^= ord(char_s)
        for char_t in t:
            xor_sum ^= ord(char_t)
        return chr(xor_sum)