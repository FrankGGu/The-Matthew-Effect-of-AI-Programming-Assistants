from collections import Counter

class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        if len(nums) <= 1:
            return 0

        even_counts = Counter(nums[::2])
        odd_counts = Counter(nums[1::2])

        even_most_common = even_counts.most_common(2)
        odd_most_common = odd_counts.most_common(2)

        if not even_most_common:
            even_most_common = [(0, 0)]
        if not odd_most_common:
            odd_most_common = [(0, 0)]

        if len(even_most_common) < 2:
            even_most_common.append((0, 0))
        if len(odd_most_common) < 2:
            odd_most_common.append((0, 0))

        if even_most_common[0][0] != odd_most_common[0][0]:
            operations = len(nums) - even_most_common[0][1] - odd_most_common[0][1]
        else:
            operations = min(
                len(nums) - even_most_common[0][1] - odd_most_common[1][1],
                len(nums) - even_most_common[1][1] - odd_most_common[0][1]
            )

        return operations