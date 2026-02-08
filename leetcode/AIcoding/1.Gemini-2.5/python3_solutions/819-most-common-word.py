import collections
import re

class Solution:
    def mostCommonWord(self, paragraph: str, banned: list[str]) -> str:
        banned_set = set(banned)

        paragraph_lower = paragraph.lower()

        cleaned_paragraph = re.sub(r'[^a-z]', ' ', paragraph_lower)

        words = [word for word in cleaned_paragraph.split() if word]

        word_counts = collections.Counter()
        for word in words:
            if word not in banned_set:
                word_counts[word] += 1

        return word_counts.most_common(1)[0][0]