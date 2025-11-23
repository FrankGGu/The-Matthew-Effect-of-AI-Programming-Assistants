class Solution:
    def maximumDifference(self, num: int) -> int:
        num_str = str(num)
        max_num = num_str
        min_num = num_str

        for original, replacement in zip("0123456789", "9876543210"):
            max_num = max_num.replace(original, replacement)

        for original, replacement in zip("0123456789", "0000000000"):
            if original != '0':
                min_num = min_num.replace(original, replacement)
                break

        return int(max_num) - int(min_num) if int(max_num) != int(min_num) else -1