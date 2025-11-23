class Solution:
    def validUtf8(self, data: List[int]) -> bool:
        i = 0
        while i < len(data):
            first_byte = data[i]
            if (first_byte >> 7) == 0:
                i += 1
            elif (first_byte >> 5) == 0b110:
                if i + 1 >= len(data) or (data[i + 1] >> 6) != 0b10:
                    return False
                i += 2
            elif (first_byte >> 4) == 0b1110:
                if i + 2 >= len(data) or (data[i + 1] >> 6) != 0b10 or (data[i + 2] >> 6) != 0b10:
                    return False
                i += 3
            elif (first_byte >> 3) == 0b11110:
                if i + 3 >= len(data) or (data[i + 1] >> 6) != 0b10 or (data[i + 2] >> 6) != 0b10 or (data[i + 3] >> 6) != 0b10:
                    return False
                i += 4
            else:
                return False
        return True