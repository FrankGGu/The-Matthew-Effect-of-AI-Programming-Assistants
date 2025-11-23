class Solution:
    def countBadPairs(self, nums: List[int]) -> int:
        n = len(nums)
        total_pairs = n * (n - 1) // 2
        good_pairs = 0
        index_map = {}

        for i, num in enumerate(nums):
            index_map[num - i] = index_map.get(num - i, 0) + 1

        for count in index_map.values():
            good_pairs += count * (count - 1) // 2

        return total_pairs - good_pairs