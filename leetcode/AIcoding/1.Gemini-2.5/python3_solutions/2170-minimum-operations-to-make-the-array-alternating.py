import collections

class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        even_counts = collections.Counter()
        odd_counts = collections.Counter()

        for i in range(n):
            if i % 2 == 0:
                even_counts[nums[i]] += 1
            else:
                odd_counts[nums[i]] += 1

        even_mc = even_counts.most_common(2)
        e1_val, e1_count = even_mc[0] if even_mc else (0, 0)
        e2_val, e2_count = even_mc[1] if len(even_mc) > 1 else (0, 0)

        odd_mc = odd_counts.most_common(2)
        o1_val, o1_count = odd_mc[0] if odd_mc else (0, 0)
        o2_val, o2_count = odd_mc[1] if len(odd_mc) > 1 else (0, 0)

        even_len = (n + 1) // 2
        odd_len = n // 2

        if e1_val != o1_val:
            operations = (even_len - e1_count) + (odd_len - o1_count)
        else:
            ops1 = (even_len - e1_count) + (odd_len - o2_count)
            ops2 = (even_len - e2_count) + (odd_len - o1_count)
            operations = min(ops1, ops2)

        return operations