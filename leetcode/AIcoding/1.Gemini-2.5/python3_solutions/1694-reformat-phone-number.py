class Solution:
    def reformatNumber(self, s: str) -> str:
        digits = [char for char in s if char.isdigit()]
        cleaned_s = "".join(digits)
        n = len(cleaned_s)

        result_parts = []

        idx = 0

        if n % 3 == 0:
            while idx < n:
                result_parts.append(cleaned_s[idx:idx+3])
                idx += 3
        elif n % 3 == 1:
            if n == 1:
                result_parts.append(cleaned_s)
            else:
                while idx < n - 4:
                    result_parts.append(cleaned_s[idx:idx+3])
                    idx += 3
                result_parts.append(cleaned_s[idx:idx+2])
                result_parts.append(cleaned_s[idx+2:idx+4])
        elif n % 3 == 2:
            while idx < n - 2:
                result_parts.append(cleaned_s[idx:idx+3])
                idx += 3
            result_parts.append(cleaned_s[idx:idx+2])

        return "-".join(result_parts)