from collections import Counter

class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        count_s = Counter(s)
        count_target = Counter(target)

        return min(count_s[char] // count_target[char] for char in count_target)