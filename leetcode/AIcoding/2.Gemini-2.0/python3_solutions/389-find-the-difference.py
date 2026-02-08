class Solution:
    def findTheDifference(self, s: str, t: str) -> str:
        s_sum = 0
        t_sum = 0
        for char in s:
            s_sum += ord(char)
        for char in t:
            t_sum += ord(char)
        return chr(t_sum - s_sum)