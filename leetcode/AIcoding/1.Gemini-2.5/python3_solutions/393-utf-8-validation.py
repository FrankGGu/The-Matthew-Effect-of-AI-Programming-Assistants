class Solution:
    def isValidUtf8(self, data: list[int]) -> bool:

        bytes_to_follow = 0

        for byte in data:
            if bytes_to_follow == 0:
                if (byte >> 7) == 0b0:  # 1-byte character (0xxxxxxx)
                    bytes_to_follow = 0
                elif (byte >> 5) == 0b110:  # 2-byte character (110xxxxx)
                    bytes_to_follow = 1
                elif (byte >> 4) == 0b1110:  # 3-byte character (1110xxxx)
                    bytes_to_follow = 2
                elif (byte >> 3) == 0b11110:  # 4-byte character (11110xxx)
                    bytes_to_follow = 3
                else:  # Invalid start byte
                    return False
            else:
                # Must be a continuation byte (10xxxxxx)
                if (byte >> 6) == 0b10:
                    bytes_to_follow -= 1
                else:  # Invalid continuation byte
                    return False

        return bytes_to_follow == 0