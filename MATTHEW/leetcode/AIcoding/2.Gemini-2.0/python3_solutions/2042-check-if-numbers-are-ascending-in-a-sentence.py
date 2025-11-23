class Solution:
    def areNumbersAscending(self, s: str) -> bool:
        nums = []
        for word in s.split():
            if word.isdigit():
                nums.append(int(word))

        for i in range(1, len(nums)):
            if nums[i] <= nums[i-1]:
                return False

        return True