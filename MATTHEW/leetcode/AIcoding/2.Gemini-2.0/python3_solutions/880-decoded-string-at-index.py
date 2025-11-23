class Solution:
    def decodeAtIndex(self, s: str, k: int) -> str:
        size = 0
        for char in s:
            if char.isdigit():
                size *= int(char)
            else:
                size += 1

        for i in range(len(s) - 1, -1, -1):
            char = s[i]
            k %= size
            if k == 0 and char.isalpha():
                return char

            if char.isdigit():
                size /= int(char)
            else:
                size -= 1