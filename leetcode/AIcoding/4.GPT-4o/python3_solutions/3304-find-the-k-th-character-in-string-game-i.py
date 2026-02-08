class Solution:
    def findKthCharacter(self, s: str, k: int) -> str:
        return s[(k - 1) % len(s)]