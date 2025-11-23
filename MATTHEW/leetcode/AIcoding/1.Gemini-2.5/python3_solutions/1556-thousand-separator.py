class Solution:
    def thousandSeparator(self, n: int) -> str:
        s = str(n)
        if len(s) <= 3:
            return s

        reversed_s = s[::-1]
        result_parts = []

        for i, char in enumerate(reversed_s):
            result_parts.append(char)
            if (i + 1) % 3 == 0 and (i + 1) < len(reversed_s):
                result_parts.append('.')

        return "".join(result_parts[::-1])