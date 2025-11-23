class Solution:
    def checkArithmeticSubarray(self, nums, l, r):
        def is_arithmetic(arr):
            if len(arr) <= 2:
                return True
            diff = arr[1] - arr[0]
            for i in range(2, len(arr)):
                if arr[i] - arr[i-1] != diff:
                    return False
            return True

        result = []
        for i in range(len(l)):
            subarray = nums[l[i]:r[i]+1]
            subarray.sort()
            result.append(is_arithmetic(subarray))
        return result