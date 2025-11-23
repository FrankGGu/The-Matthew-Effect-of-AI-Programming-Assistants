class Solution:
    def distributeArray(self, nums: List[int]) -> List[List[int]]:
        from collections import Counter
        count = Counter(nums)
        a, b = [], []

        for num, freq in count.items():
            half = freq // 2
            a.extend([num] * half)
            b.extend([num] * (freq - half))

        return [a, b]