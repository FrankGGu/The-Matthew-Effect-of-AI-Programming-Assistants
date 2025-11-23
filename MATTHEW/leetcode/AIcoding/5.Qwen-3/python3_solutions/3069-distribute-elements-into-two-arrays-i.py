class Solution:
    def distributeElements(self, nums: List[int]) -> List[List[int]]:
        a = []
        b = []
        for num in nums:
            if len(a) <= len(b):
                a.append(num)
            else:
                b.append(num)
        return [a, b]