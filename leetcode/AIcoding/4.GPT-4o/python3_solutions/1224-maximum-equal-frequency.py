class Solution:
    def maxEqualFreq(self, nums: List[int]) -> int:
        count = collections.Counter()
        freq = collections.Counter()
        max_len = 0

        for i, num in enumerate(nums):
            if count[num] > 0:
                freq[count[num]] -= 1
                if freq[count[num]] == 0:
                    del freq[count[num]]
            count[num] += 1
            freq[count[num]] += 1

            if len(freq) == 1:
                key = next(iter(freq))
                if key == 1 or freq[key] == 1:
                    max_len = max(max_len, i + 1)
            elif len(freq) == 2:
                keys = list(freq.keys())
                k1, k2 = keys[0], keys[1]
                if (freq[k1] == 1 and (k1 - 1 == k2 or k1 - 1 == 0)) or (freq[k2] == 1 and (k2 - 1 == k1 or k2 - 1 == 0)):
                    max_len = max(max_len, i + 1)

        return max_len