import collections
from typing import List

class Solution:
    def minimumBeautifulSubarrays(self, flowers: List[int], target: int, k: int) -> int:
        n = len(flowers)
        left = 0
        current_sum = 0
        min_length = float('inf')
        distinct_counts = collections.defaultdict(int)

        for right in range(n):
            current_sum += flowers[right]
            distinct_counts[flowers[right]] += 1

            while len(distinct_counts) > k:
                current_sum -= flowers[left]
                distinct_counts[flowers[left]] -= 1
                if distinct_counts[flowers[left]] == 0:
                    del distinct_counts[flowers[left]]
                left += 1

            while current_sum >= target:
                min_length = min(min_length, right - left + 1)

                current_sum -= flowers[left]
                distinct_counts[flowers[left]] -= 1
                if distinct_counts[flowers[left]] == 0:
                    del distinct_counts[flowers[left]]
                left += 1

        return min_length if min_length != float('inf') else -1