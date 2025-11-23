class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        res = []
        pos = [x for x in nums if x > 0]
        neg = [x for x in nums if x < 0]

        for i in range(len(nums)):
            if i % 2 == 0:
                res.append(pos.pop())
            else:
                res.append(neg.pop())

        return res