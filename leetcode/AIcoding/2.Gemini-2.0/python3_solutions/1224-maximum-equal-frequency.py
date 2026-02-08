from collections import Counter

class Solution:
    def maxEqualFreq(self, nums: list[int]) -> int:
        freq = Counter()
        count = Counter()
        max_freq = 0
        res = 0

        for i, num in enumerate(nums):
            if num in freq:
                count[freq[num]] -= 1
                if count[freq[num]] == 0:
                    del count[freq[num]]
            freq[num] += 1
            count[freq[num]] += 1
            max_freq = max(max_freq, freq[num])

            if max_freq == 1:
                res = i + 1
            elif len(count) == 2:
                if 1 in count and count[1] == 1:
                    res = i + 1
                else:
                    freq_vals = sorted(count.keys())
                    if freq_vals[1] - freq_vals[0] == 1 and count[freq_vals[1]] == 1:
                        res = i + 1
            elif len(count) == 1:
                if max_freq == 1 or count[max_freq] == 1:
                    res = i + 1

        return res