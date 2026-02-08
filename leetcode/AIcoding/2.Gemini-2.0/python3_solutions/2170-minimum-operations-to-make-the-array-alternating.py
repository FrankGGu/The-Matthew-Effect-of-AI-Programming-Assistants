from collections import Counter

class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0

        even = nums[::2]
        odd = nums[1::2]

        even_counts = Counter(even)
        odd_counts = Counter(odd)

        even_most_common = even_counts.most_common(2)
        odd_most_common = odd_counts.most_common(2)

        if even_most_common[0][0] != odd_most_common[0][0]:
            return n - even_most_common[0][1] - odd_most_common[0][1]
        else:
            if len(even_most_common) == 1 and len(odd_most_common) == 1:
                return min(len(even) , len(odd))
            elif len(even_most_common) == 1:
                return len(odd) - odd_most_common[1][1]
            elif len(odd_most_common) == 1:
                return len(even) - even_most_common[1][1]
            else:
                return min(n - even_most_common[0][1] - odd_most_common[1][1], n - even_most_common[1][1] - odd_most_common[0][1])