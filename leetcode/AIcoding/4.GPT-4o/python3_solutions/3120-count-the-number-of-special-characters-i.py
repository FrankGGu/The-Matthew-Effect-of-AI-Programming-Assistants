class Solution:
    def countSpecialCharacters(self, s: str) -> int:
        return sum(1 for char in s if not char.isalnum())