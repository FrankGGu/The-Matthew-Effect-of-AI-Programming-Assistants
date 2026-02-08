class Solution:
    def countInterestingSubarrays(self, nums: List[int], modulo: int, k: int) -> int:
        prefix_counts = defaultdict(int)
        prefix_counts[0] = 1
        current = 0
        result = 0

        for num in nums:
            if num % modulo == k:
                current = (current + 1) % modulo
            key = (current - k) % modulo
            result += prefix_counts.get(key, 0)
            prefix_counts[current] += 1

        return result