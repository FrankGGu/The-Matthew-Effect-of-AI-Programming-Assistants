class Solution:
    def countVowelStrings(self, n: int) -> int:
        return (5 ** n) - (10 * (n - 1) * (n - 2) // 2) if n > 1 else 5