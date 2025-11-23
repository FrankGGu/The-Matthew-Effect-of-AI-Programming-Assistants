class Solution:
    def flowerGame(self, flowers: List[int]) -> str:
        total = sum(flowers)
        if total % 2 == 1:
            return "Alice"
        return "Bob" if total // 2 % 2 == 0 else "Alice"