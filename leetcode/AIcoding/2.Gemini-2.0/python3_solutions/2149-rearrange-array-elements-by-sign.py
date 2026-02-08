class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        pos = []
        neg = []
        for num in nums:
            if num > 0:
                pos.append(num)
            else:
                neg.append(num)

        res = []
        for i in range(len(nums) // 2):
            res.append(pos[i])
            res.append(neg[i])

        return res