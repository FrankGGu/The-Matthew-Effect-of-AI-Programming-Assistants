class Solution:
    def partitionString(self, s: str) -> int:
        count = 1
        seen = set()
        for char in s:
            if char in seen:
                count += 1
                seen = set()
            seen.add(char)
        return count