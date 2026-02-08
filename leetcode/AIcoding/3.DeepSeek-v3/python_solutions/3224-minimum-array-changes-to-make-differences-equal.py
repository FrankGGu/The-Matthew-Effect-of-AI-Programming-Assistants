class Solution:
    def minChanges(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0

        diffs = []
        for i in range(n - 1):
            diffs.append(nums[i + 1] - nums[i])

        if all(d == 0 for d in diffs):
            return 0

        max_freq = 0
        freq = {}
        for d in diffs:
            if d in freq:
                freq[d] += 1
            else:
                freq[d] = 1
            if freq[d] > max_freq:
                max_freq = freq[d]

        return (n - 1) - max_freq