import collections

class Solution:
    def maximumDistinctElements(self, nums: list[int], k: int) -> int:
        counts = collections.Counter(nums)

        initial_distinct_count = len(counts)

        total_duplicates_available_to_change = 0
        for count in counts.values():
            if count > 1:
                total_duplicates_available_to_change += (count - 1)

        # Each operation can be used to change a duplicate element into a new distinct element.
        # This increases the total distinct count by 1 per operation.
        # We can perform at most 'k' such operations.
        # The number of elements we can change is also limited by the 'total_duplicates_available_to_change'.

        # The maximum number of new distinct elements we can create is limited by 'k'
        # and the total number of redundant (duplicate) elements we can change.
        added_distinct_elements = min(k, total_duplicates_available_to_change)

        return initial_distinct_count + added_distinct_elements