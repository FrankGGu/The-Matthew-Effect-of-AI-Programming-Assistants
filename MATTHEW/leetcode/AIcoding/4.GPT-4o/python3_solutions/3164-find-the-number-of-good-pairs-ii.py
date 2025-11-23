class Solution:
    def countGoodPairs(self, nums: List[int]) -> int:
        count = defaultdict(int)
        total_pairs = 0

        for num in nums:
            total_pairs += count[num]
            count[num] += 1

        return total_pairs