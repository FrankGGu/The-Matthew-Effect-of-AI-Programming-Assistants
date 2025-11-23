class Solution:
    def decodeAtIndex(self, s: str, k: int) -> str:
        size = 0
        for char in s:
            if char.isdigit():
                size *= int(char)
            else:
                size += 1
        for char in reversed(s):
            if char.isdigit():
                size //= int(char)
            else:
                if k == size:
                    return char
                size -= 1
        return ""