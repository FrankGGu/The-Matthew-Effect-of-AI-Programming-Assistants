class Solution:
    def numberOfUniqueNum(self, n: int) -> int:
        seen = set()
        for i in range(1, n + 1):
            seen.add(i)
            seen.add(i * 2)
            seen.add(i * 3)
        return len(seen)