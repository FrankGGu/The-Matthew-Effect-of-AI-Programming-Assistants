class Solution:
    def secondsToRemoveOccurrences(self, s: str) -> int:
        s = list(s)
        seconds = 0
        while '01' in ''.join(s):
            for i in range(len(s) - 1):
                if s[i] == '0' and s[i + 1] == '1':
                    s[i], s[i + 1] = s[i + 1], s[i]
                    i += 1
            seconds += 1
        return seconds