import collections
from typing import List

class Solution:
    def subsequencesWithUniqueMiddleMode(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0

        for i in range(1, 1 << n):
            current_subsequence = []
            for j in range(n):
                if (i >> j) & 1:
                    current_subsequence.append(nums[j])

            current_subsequence.sort()

            sub_len = len(current_subsequence)
            if sub_len == 0:
                continue

            is_unique_middle_mode = False

            freq_map = collections.Counter(current_subsequence)

            if sub_len % 2 == 1:
                middle_val = current_subsequence[sub_len // 2]
                if freq_map[middle_val] == 1:
                    is_unique_middle_mode = True
            else:
                middle_val1 = current_subsequence[sub_len // 2 - 1]
                middle_val2 = current_subsequence[sub_len // 2]

                if freq_map[middle_val1] == 1 and freq_map[middle_val2] == 1:
                    is_unique_middle_mode = True

            if is_unique_middle_mode:
                count += 1

        return count