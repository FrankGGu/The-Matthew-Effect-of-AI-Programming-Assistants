class Solution:
    def toHex(self, num: int) -> str:
        if num == 0:
            return "0"
        hex_chars = "0123456789abcdef"
        hex_str = ""
        for _ in range(8):
            if num == 0:
                break
            hex_str = hex_chars[num & 15] + hex_str
            num >>= 4
        return hex_str