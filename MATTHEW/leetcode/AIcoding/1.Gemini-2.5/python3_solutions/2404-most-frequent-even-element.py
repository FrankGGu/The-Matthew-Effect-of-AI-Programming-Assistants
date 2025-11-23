import collections

class Solution:
    def mostFrequentEven(self, nums: list[int]) -> int:
        counts = collections.defaultdict(int)
        for num in nums:
            if num % 2 == 0:
                counts[num] += 1

        if not counts:
            return -1

        max_freq = -1
        result = -1

        for num, freq in counts.items():
            if freq > max_freq:
                max_freq = freq
                result = num
            elif freq == max_freq:
                if num < result:
                    result = num

        return result