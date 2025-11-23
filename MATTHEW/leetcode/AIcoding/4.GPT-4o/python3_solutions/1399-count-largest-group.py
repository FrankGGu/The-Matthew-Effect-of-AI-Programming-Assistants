class Solution:
    def countLargestGroup(self, n: int) -> int:
        from collections import Counter

        def digit_sum(x):
            return sum(int(d) for d in str(x))

        group_sizes = Counter(digit_sum(i) for i in range(1, n + 1))
        max_size = max(group_sizes.values())

        return sum(1 for size in group_sizes.values() if size == max_size)