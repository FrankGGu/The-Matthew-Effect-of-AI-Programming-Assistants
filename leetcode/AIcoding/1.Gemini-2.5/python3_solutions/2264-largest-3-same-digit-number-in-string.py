class Solution:
    def largestGoodInteger(self, num: str) -> str:

        for digit_char in "9876543210":
            target = digit_char * 3
            if target in num:
                return target

        return ""