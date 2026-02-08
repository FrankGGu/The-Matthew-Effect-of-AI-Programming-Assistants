import collections

class Solution:
    def minSetSize(self, arr: list[int]) -> int:
        n = len(arr)
        target_size = n // 2

        counts = collections.Counter(arr)

        sorted_counts = sorted(counts.values(), reverse=True)

        removed_elements_count = 0
        set_size = 0

        for count in sorted_counts:
            removed_elements_count += count
            set_size += 1
            if removed_elements_count >= target_size:
                return set_size

        return set_size