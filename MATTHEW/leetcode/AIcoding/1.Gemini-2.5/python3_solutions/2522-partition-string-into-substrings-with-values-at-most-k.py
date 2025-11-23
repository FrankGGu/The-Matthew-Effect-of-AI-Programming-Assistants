class Solution:
    def minimumPartition(self, s: str, k: int) -> int:
        count = 1
        current_num = 0

        for char_digit in s:
            digit = int(char_digit)

            new_num = current_num * 2 + digit

            if new_num <= k:
                current_num = new_num
            else:
                count += 1
                current_num = digit

        return count