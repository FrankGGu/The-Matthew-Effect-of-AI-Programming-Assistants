from collections import Counter

class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        s_count = Counter(s)
        target_count = Counter(target)

        ans = float('inf')
        for char, count in target_count.items():
            if char not in s_count:
                return 0
            ans = min(ans, s_count[char] // count)

        return ans