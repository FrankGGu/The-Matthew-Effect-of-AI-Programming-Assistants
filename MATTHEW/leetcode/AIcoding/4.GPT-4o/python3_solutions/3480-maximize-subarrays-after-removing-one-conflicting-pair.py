class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        freq = Counter(nums)
        max_sum = 0

        for num in sorted(freq.keys(), reverse=True):
            total = sum(num + i for i in range(k) if num + i in freq)
            max_sum = max(max_sum, total)

        return max_sum