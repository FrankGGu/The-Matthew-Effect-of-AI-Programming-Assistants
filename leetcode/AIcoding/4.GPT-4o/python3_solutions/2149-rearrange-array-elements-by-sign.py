class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        positive = [x for x in nums if x > 0]
        negative = [x for x in nums if x < 0]
        return [val for pair in zip(positive, negative) for val in pair]