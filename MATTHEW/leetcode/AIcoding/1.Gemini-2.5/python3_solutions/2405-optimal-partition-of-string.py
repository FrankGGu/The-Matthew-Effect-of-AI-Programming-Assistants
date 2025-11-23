class Solution:
    def partitionString(self, s: str) -> int:
        partitions = 1
        current_chars = set()

        for char_code in s:
            if char_code in current_chars:
                partitions += 1
                current_chars.clear()
            current_chars.add(char_code)

        return partitions