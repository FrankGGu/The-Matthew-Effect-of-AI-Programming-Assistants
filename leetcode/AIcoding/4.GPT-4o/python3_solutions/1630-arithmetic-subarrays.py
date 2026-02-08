class Solution:
    def checkArithmeticSubarrays(self, nums: List[int], l: List[int], r: List[int]) -> List[bool]:
        def is_arithmetic(subarray):
            if len(subarray) < 2:
                return True
            d = subarray[1] - subarray[0]
            for i in range(2, len(subarray)):
                if subarray[i] - subarray[i - 1] != d:
                    return False
            return True

        result = []
        for start, end in zip(l, r):
            result.append(is_arithmetic(sorted(nums[start:end + 1])))
        return result