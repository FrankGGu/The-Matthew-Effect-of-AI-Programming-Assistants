class Solution:
    def check(self, arr):
        if len(arr) < 3:
            return True
        arr.sort()
        diff = arr[1] - arr[0]
        for i in range(2, len(arr)):
            if arr[i] - arr[i - 1] != diff:
                return False
        return True

    def arithmeticSubarrays(self, nums: List[int], l: List[int], r: List[int]) -> List[bool]:
        res = []
        for i in range(len(l)):
            sub_array = nums[l[i]:r[i] + 1]
            res.append(self.check(sub_array))
        return res