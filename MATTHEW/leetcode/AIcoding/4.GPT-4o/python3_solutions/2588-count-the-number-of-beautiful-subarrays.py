class Solution:
    def countBeautifulSubarrays(self, nums: List[int]) -> int:
        from collections import defaultdict

        prefix_count = defaultdict(int)
        prefix_count[0] = 1
        count = 0
        prefix_xor = 0

        for num in nums:
            prefix_xor ^= num
            count += prefix_count[prefix_xor]
            prefix_count[prefix_xor] += 1

        return count