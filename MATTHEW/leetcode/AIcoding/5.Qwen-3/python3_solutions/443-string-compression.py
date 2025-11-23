class Solution:
    def compress(self, chars: List[str]) -> int:
        if not chars:
            return 0
        index = 0
        count = 1
        for i in range(1, len(chars)):
            if chars[i] == chars[i - 1]:
                count += 1
            else:
                chars[index] = chars[i - 1]
                index += 1
                if count > 1:
                    for c in str(count):
                        chars[index] = c
                        index += 1
                count = 1
        chars[index] = chars[-1]
        index += 1
        if count > 1:
            for c in str(count):
                chars[index] = c
                index += 1
        return index