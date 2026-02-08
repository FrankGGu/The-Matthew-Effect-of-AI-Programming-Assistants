class Solution:
    def repeatLimitedString(self, s: str, repeatLimit: int) -> str:
        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        chars = sorted(counts.keys(), reverse=True)

        result = ""
        i = 0
        while i < len(chars):
            char = chars[i]
            count = counts[char]

            if count <= repeatLimit:
                result += char * count

                i += 1
            else:
                result += char * repeatLimit
                counts[char] -= repeatLimit

                if i + 1 < len(chars):
                    next_char = chars[i+1]
                    result += next_char
                    counts[next_char] -= 1
                    if counts[next_char] == 0:
                        del chars[i+1]

                else:
                    break

        return result