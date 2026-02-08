from collections import defaultdict

class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        s_count = defaultdict(int)
        target_count = defaultdict(int)

        for char in s:
            s_count[char] += 1

        for char in target:
            target_count[char] += 1

        max_copies = float('inf')

        for char in target_count:
            if char not in s_count:
                return 0
            max_copies = min(max_copies, s_count[char] // target_count[char])

        return max_copies