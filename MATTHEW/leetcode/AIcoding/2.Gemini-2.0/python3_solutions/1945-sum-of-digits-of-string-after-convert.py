class Solution:
    def getLucky(self, s: str, k: int) -> int:
        nums = ""
        for char in s:
            nums += str(ord(char) - ord('a') + 1)

        for _ in range(k):
            sum_digits = 0
            for digit in nums:
                sum_digits += int(digit)
            nums = str(sum_digits)

        return int(nums)