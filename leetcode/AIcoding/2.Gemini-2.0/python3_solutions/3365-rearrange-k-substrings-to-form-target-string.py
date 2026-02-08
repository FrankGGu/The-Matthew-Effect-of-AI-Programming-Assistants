from collections import Counter

class Solution:
    def canRearrange(self, s: str, target: str, k: int) -> bool:
        s_count = Counter(s)
        target_count = Counter(target)

        for char, count in target_count.items():
            if char not in s_count:
                return False

            if s_count[char] < count:
                return False

        for char, count in target_count.items():
            s_count[char] -= count

        total_chars = sum(target_count.values())

        return True if total_chars % k == 0 else False