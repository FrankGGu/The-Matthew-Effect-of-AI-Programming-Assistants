class Solution:
    def sortEvenOdd(self, nums: List[int]) -> List[int]:
        even = nums[::2]
        odd = nums[1::2]
        even.sort()
        odd.sort(reverse=True)
        res = []
        for i in range(len(nums)):
            if i % 2 == 0:
                res.append(even[i//2])
            else:
                res.append(odd[i//2])
        return res