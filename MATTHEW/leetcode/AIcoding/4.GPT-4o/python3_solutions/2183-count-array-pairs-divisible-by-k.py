class Solution:
    def countPairs(self, nums: List[int], k: int) -> int:
        from collections import Counter

        count = 0
        freq = Counter(num % k for num in nums)

        for r1 in freq:
            for r2 in freq:
                if (r1 + r2) % k == 0:
                    if r1 == r2:
                        count += freq[r1] * (freq[r1] - 1) // 2
                    elif r1 < r2:
                        count += freq[r1] * freq[r2]

        return count