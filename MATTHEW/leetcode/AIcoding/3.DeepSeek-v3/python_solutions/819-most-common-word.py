import re
from collections import defaultdict

class Solution:
    def mostCommonWord(self, paragraph: str, banned: List[str]) -> str:
        words = re.findall(r'\w+', paragraph.lower())
        banned_set = set(banned)
        freq = defaultdict(int)
        max_count = 0
        result = ""

        for word in words:
            if word not in banned_set:
                freq[word] += 1
                if freq[word] > max_count:
                    max_count = freq[word]
                    result = word

        return result