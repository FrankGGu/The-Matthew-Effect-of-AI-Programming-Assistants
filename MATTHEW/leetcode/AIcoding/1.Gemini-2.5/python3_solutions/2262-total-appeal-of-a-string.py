class Solution:
    def appealSum(self, s: str) -> int:
        n = len(s)
        total_appeal = 0
        last_occurrence = [-1] * 26 

        for i in range(n):
            char_code = ord(s[i]) - ord('a')

            left_count = i - last_occurrence[char_code]
            right_count = n - i

            total_appeal += left_count * right_count

            last_occurrence[char_code] = i

        return total_appeal