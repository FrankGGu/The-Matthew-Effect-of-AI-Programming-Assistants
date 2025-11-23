class Solution:
    def checkArithmeticSubarrays(self, nums: List[int], l: List[int], r: List[int]) -> List[bool]:
        result = []
        for i in range(len(l)):
            left = l[i]
            right = r[i]
            subarray = nums[left:right+1]
            subarray.sort()
            diff = subarray[1] - subarray[0]
            is_arithmetic = True
            for j in range(2, len(subarray)):
                if subarray[j] - subarray[j-1] != diff:
                    is_arithmetic = False
                    break
            result.append(is_arithmetic)
        return result