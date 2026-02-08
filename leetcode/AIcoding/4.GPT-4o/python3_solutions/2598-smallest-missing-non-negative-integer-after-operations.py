class Solution:
    def findSmallestInteger(self, nums: List[int], value: int) -> int:
        n = len(nums)
        offset = sum((num + value) // value for num in nums)
        count = [0] * (n + offset + 1)

        for num in nums:
            count[(num + value) % value] += 1

        for i in range(len(count)):
            if count[i] == 0:
                return i
        return -1