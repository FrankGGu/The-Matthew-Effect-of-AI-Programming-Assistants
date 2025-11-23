class Solution:
    def numberOfPairs(self, nums1: List[int], nums2: List[int], k: int) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        for num in nums2:
            freq[num * k] += 1

        count = 0
        for num in nums1:
            for d in range(1, int(num ** 0.5) + 1):
                if num % d == 0:
                    count += freq.get(d, 0)
                    if d != num // d:
                        count += freq.get(num // d, 0)
        return count