class Solution:
    def solve(self, s: str, t: str) -> bool:
        return t in s or t[::-1] in s