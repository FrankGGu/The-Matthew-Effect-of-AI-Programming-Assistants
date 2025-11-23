class Solution:
    def maximumBalancedSum(self, nums: List[int]) -> int:
        count = Counter()
        total = 0

        for num in nums:
            count[num] += 1
            total += num

        max_sum = 0

        for key in count:
            if count[key] >= 2:
                max_sum = max(max_sum, key * 2)

        return max_sum + (total - sum(key * count[key] for key in count))