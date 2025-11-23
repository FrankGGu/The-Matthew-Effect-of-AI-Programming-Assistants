import re
from collections import Counter

class Solution:
    def mostCommonWord(self, paragraph: str, banned: list[str]) -> str:
        words = re.findall(r'\b\w+\b', paragraph.lower())
        count = Counter(w for w in words if w not in banned)
        return count.most_common(1)[0][0]