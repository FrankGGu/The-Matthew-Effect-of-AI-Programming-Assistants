class Solution:
    def clearDigits(self, s: str) -> str:
        return ''.join(filter(lambda x: x not in '0123456789', s))