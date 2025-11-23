from typing import List

class Solution:
    def compress(self, chars: List[str]) -> int:
        write_idx = 0
        read_idx = 0
        n = len(chars)

        while read_idx < n:
            current_char = chars[read_idx]
            count = 0

            while read_idx < n and chars[read_idx] == current_char:
                count += 1
                read_idx += 1

            chars[write_idx] = current_char
            write_idx += 1

            if count > 1:
                count_str = str(count)
                for digit in count_str:
                    chars[write_idx] = digit
                    write_idx += 1

        return write_idx