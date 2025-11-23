import collections

class Solution:
    def maxEqualFreq(self, nums: list[int]) -> int:
        num_counts = collections.defaultdict(int)
        freq_counts = collections.defaultdict(int)
        max_freq_so_far = 0
        ans = 0

        for i in range(len(nums)):
            num = nums[i]
            current_len = i + 1

            old_freq = num_counts[num]

            if old_freq > 0:
                freq_counts[old_freq] -= 1
                if freq_counts[old_freq] == 0:
                    del freq_counts[old_freq]

            new_freq = old_freq + 1
            num_counts[num] = new_freq
            freq_counts[new_freq] += 1

            max_freq_so_far = max(max_freq_so_far, new_freq)

            if max_freq_so_far == 1:
                ans = current_len

            elif len(freq_counts) == 1 and freq_counts[max_freq_so_far] == 1:
                ans = current_len

            elif len(freq_counts) == 2:
                if freq_counts[max_freq_so_far] == 1 and \
                   (max_freq_so_far - 1) in freq_counts and \
                   freq_counts[max_freq_so_far - 1] * (max_freq_so_far - 1) + max_freq_so_far == current_len:
                    ans = current_len

                elif freq_counts[1] == 1 and \
                     max_freq_so_far in freq_counts and \
                     freq_counts[max_freq_so_far] * max_freq_so_far + 1 == current_len:
                    ans = current_len

        return ans