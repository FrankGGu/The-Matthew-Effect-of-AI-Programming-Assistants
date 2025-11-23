class Solution:
    def minNumOfStrings(self, strings: List[str], target: str) -> int:
        from collections import Counter

        def can_construct(s_count, t_count):
            for char in t_count:
                if s_count[char] < t_count[char]:
                    return False
            return True

        n = len(strings)
        min_count = float('inf')

        for i in range(1, 1 << n):
            current_count = Counter()
            str_count = 0

            for j in range(n):
                if i & (1 << j):
                    str_count += 1
                    current_count += Counter(strings[j])

            if can_construct(current_count, Counter(target)):
                min_count = min(min_count, str_count)

        return min_count if min_count != float('inf') else -1