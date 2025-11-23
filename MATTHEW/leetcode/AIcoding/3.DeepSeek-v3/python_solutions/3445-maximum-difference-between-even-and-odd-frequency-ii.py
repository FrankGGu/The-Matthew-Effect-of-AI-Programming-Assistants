class Solution:
    def maxDifference(self, nums: List[int]) -> int:
        from collections import defaultdict

        even_freq = defaultdict(int)
        odd_freq = defaultdict(int)

        for num in nums:
            if num in even_freq:
                del even_freq[num]
                odd_freq[num] += 1
            elif num in odd_freq:
                del odd_freq[num]
                even_freq[num] += 1
            else:
                even_freq[num] = 1

        max_even = max(even_freq.values()) if even_freq else 0
        min_odd = min(odd_freq.values()) if odd_freq else 0

        if not odd_freq:
            return max_even
        if not even_freq:
            return -min_odd

        return max_even - min_odd