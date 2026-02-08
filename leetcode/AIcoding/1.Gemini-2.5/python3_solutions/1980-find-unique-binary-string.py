class Solution:
    def findDifferentBinaryString(self, nums: List[str]) -> str:
        n = len(nums)
        nums_set = set(nums)

        for i in range(1 << n):
            binary_string = format(i, '0{}b'.format(n))
            if binary_string not in nums_set:
                return binary_string

        return ""