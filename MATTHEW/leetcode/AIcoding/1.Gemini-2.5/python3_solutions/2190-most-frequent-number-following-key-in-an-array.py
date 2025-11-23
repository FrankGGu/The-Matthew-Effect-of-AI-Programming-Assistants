import collections

class Solution:
    def mostFrequent(self, nums: List[int], key: int) -> int:
        counts = collections.defaultdict(int)

        # Iterate through the array to find occurrences of `key`
        # and count the numbers immediately following them.
        for i in range(len(nums) - 1):
            if nums[i] == key:
                target = nums[i+1]
                counts[target] += 1

        max_freq = 0
        result = -1 # Initialize result with a value outside the possible target range (0-1000)
                    # This ensures the first valid target will set the result.

        # Iterate through the collected counts to find the target with the maximum frequency.
        # In case of a tie in frequency, choose the smallest target.
        for target, freq in counts.items():
            if freq > max_freq:
                max_freq = freq
                result = target
            elif freq == max_freq:
                # If current target has the same frequency as the current max_freq,
                # we choose the smaller target.
                if target < result:
                    result = target

        return result