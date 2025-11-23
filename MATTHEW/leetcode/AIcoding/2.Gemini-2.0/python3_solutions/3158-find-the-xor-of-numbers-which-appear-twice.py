class Solution:
    def findXOR(self, nums: List[int]) -> int:
        xor = 0
        count = {}
        for num in nums:
            if num in count:
                count[num] += 1
            else:
                count[num] = 1
        for num in count:
            if count[num] == 2:
                xor ^= num
        return xor