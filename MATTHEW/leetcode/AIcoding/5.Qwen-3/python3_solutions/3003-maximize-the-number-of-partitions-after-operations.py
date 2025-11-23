class Solution:
    def maxPartitions(self, s: str) -> int:
        from collections import defaultdict

        def get_partition_count(s):
            count = 0
            seen = set()
            for c in s:
                if c in seen:
                    continue
                seen.add(c)
                count += 1
            return count

        n = len(s)
        result = 0
        for i in range(1, n):
            left = s[:i]
            right = s[i:]
            if get_partition_count(left) + get_partition_count(right) > result:
                result = get_partition_count(left) + get_partition_count(right)
        return result