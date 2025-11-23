class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        from collections import defaultdict

        s_count = defaultdict(int)
        target_count = defaultdict(int)

        for char in s:
            s_count[char] += 1

        for char in target:
            target_count[char] += 1

        min_ratio = float('inf')

        for char in target_count:
            if s_count[char] < target_count[char]:
                return 0
            ratio = s_count[char] // target_count[char]
            if ratio < min_ratio:
                min_ratio = ratio

        return min_ratio