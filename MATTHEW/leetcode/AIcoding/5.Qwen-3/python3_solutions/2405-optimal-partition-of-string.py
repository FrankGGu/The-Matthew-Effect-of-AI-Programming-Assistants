class Solution:
    def partitionString(self, s: str) -> int:
        seen = set()
        count = 1
        for char in s:
            if char in seen:
                seen = {char}
                count += 1
            else:
                seen.add(char)
        return count