from collections import Counter

class Solution:
    def maxDistinctElements(self, nums: list[int], k: int) -> int:
        count = Counter(nums)
        freq = list(count.values())
        freq.sort()
        distinct_count = len(count)

        for f in freq:
            if f == 1:
                continue

            needed = f - 1
            if k >= needed:
                k -= needed
                distinct_count -= 1
            else:
                break

        distinct_count -= min(distinct_count, k // 2)

        return distinct_count