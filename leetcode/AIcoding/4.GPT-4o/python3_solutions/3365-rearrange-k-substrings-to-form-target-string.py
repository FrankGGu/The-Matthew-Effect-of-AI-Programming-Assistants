class Solution:
    def canRearrange(self, s: str, k: int, target: str) -> bool:
        from collections import Counter

        if len(s) < k or len(target) != k:
            return False

        s_count = Counter(s)
        target_count = Counter(target)

        for char, count in target_count.items():
            if s_count[char] < count:
                return False

        return True