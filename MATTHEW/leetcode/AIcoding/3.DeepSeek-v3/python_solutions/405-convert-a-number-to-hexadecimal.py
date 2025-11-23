class Solution:
    def toHex(self, num: int) -> str:
        if num == 0:
            return "0"
        hex_chars = "0123456789abcdef"
        res = []
        for _ in range(8):
            res.append(hex_chars[num & 0xf])
            num >>= 4
            if num == 0:
                break
        return ''.join(reversed(res))