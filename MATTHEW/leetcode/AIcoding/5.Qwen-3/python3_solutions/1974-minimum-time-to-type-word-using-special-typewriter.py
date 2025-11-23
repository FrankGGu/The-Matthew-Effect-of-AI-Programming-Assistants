class Solution:
    def minTimeToType(self, word: str) -> int:
        time = 0
        prev = 0
        for c in word:
            curr = ord(c) - ord('a')
            diff = abs(curr - prev)
            time += min(diff, 26 - diff)
            prev = curr
        return time