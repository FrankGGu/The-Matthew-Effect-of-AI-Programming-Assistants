class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        result = []

        for i in range(n):
            # Calculate the number of remaining characters after the current one
            remaining_len = n - 1 - i

            # Determine the smallest possible value for the current character
            # This value must be at least 1 ('a')
            # It also must be large enough so that the remaining characters (n-1-i)
            # can sum up to the remaining k.
            # If all remaining characters were 'z' (26), their sum would be remaining_len * 26.
            # So, the current character must contribute at least k - (remaining_len * 26)
            # to make up the sum.
            char_val = max(1, k - remaining_len * 26)

            # The character value cannot exceed 26 ('z')
            char_val = min(char_val, 26)

            result.append(chr(ord('a') + char_val - 1))
            k -= char_val

        return "".join(result)