class Solution:
    def countHomogenous(self, s: str) -> int:
        count = 0
        curr_len = 0
        curr_char = ''

        for char in s:
            if char == curr_char:
                curr_len += 1
            else:
                curr_char = char
                curr_len = 1
            count = (count + curr_len) % (10**9 + 7)

        return count