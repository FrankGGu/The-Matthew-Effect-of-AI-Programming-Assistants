class Solution:
    def validUtf8Encoding(self, data: List[int]) -> bool:
        if not data:
            return False
        bytes_to_read = 0
        for byte in data:
            if bytes_to_read == 0:
                if (byte >> 7) == 0b0:
                    continue
                elif (byte >> 5) == 0b110:
                    bytes_to_read = 1
                elif (byte >> 4) == 0b1110:
                    bytes_to_read = 2
                elif (byte >> 3) == 0b11110:
                    bytes_to_read = 3
                else:
                    return False
            else:
                if (byte >> 6) != 0b10:
                    return False
                bytes_to_read -= 1
        return bytes_to_read == 0