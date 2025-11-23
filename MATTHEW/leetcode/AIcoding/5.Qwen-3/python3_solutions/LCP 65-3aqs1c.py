class Solution:
    def humidity(self, s: str) -> int:
        return int(s.split('%')[0])