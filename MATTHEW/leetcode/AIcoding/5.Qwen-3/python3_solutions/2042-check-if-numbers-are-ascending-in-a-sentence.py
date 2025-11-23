class Solution:
    def areNumbersAscending(self, s: str) -> bool:
        nums = []
        i = 0
        while i < len(s):
            if s[i].isdigit():
                num = 0
                while i < len(s) and s[i].isdigit():
                    num = num * 10 + int(s[i])
                    i += 1
                nums.append(num)
            else:
                i += 1
        for j in range(1, len(nums)):
            if nums[j] <= nums[j - 1]:
                return False
        return True