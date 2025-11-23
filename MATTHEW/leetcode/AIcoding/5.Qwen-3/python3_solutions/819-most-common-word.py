import re
from collections import Counter

class Solution:
    def mostCommonWord(self, paragraph: str, banned: List[str]) -> str:
        words = re.findall(r'\w+', paragraph.lower())
        word_count = Counter(words)
        for word in banned:
            if word in word_count:
                del word_count[word]
        return word_count.most_common(1)[0][0]