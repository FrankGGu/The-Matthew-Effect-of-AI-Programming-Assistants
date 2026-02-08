from collections import defaultdict

class Solution:
    def maxEqualFreq(self, nums: List[int]) -> int:
        freq = defaultdict(int)
        count = defaultdict(int)
        res = 0
        max_freq = 0

        for i, num in enumerate(nums):
            if count[num]:
                freq[count[num]] -= 1
                if freq[count[num]] == 0:
                    del freq[count[num]]
            count[num] += 1
            freq[count[num]] += 1
            max_freq = max(max_freq, count[num])

            if (max_freq == 1) or \
               (freq[max_freq] == 1 and max_freq + (max_freq - 1) * freq[max_freq - 1] == i + 1) or \
               (freq[1] == 1 and max_freq * freq[max_freq] == i):
                res = i + 1

        return res