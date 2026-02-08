class Solution:
    def compress(self, chars: List[str]) -> int:
        n = len(chars)
        if n == 0:
            return 0
        write = 0
        read = 0
        while read < n:
            current_char = chars[read]
            count = 0
            while read < n and chars[read] == current_char:
                read += 1
                count += 1
            chars[write] = current_char
            write += 1
            if count > 1:
                for digit in str(count):
                    chars[write] = digit
                    write += 1
        return write