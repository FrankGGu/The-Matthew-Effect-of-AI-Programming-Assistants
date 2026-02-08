class Solution:
    def separateDigits(self, nums: list[int]) -> list[int]:
        ans = []
        for num in nums:
            s_num = str(num)
            for char_digit in s_num:
                ans.append(int(char_digit))
        return ans