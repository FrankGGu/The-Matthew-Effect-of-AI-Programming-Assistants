class Solution:
    def destroyTargets(self, nums: List[int], space: int) -> int:
        freq = defaultdict(int)
        max_freq = 0
        for num in nums:
            mod = num % space
            freq[mod] += 1
            if freq[mod] > max_freq:
                max_freq = freq[mod]

        candidates = []
        for num in nums:
            mod = num % space
            if freq[mod] == max_freq:
                candidates.append(num)

        return min(candidates)