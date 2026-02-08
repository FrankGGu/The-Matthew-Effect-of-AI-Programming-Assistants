from collections import Counter

class Solution:
    def topKFrequent(self, words: List[str], k: int) -> List[str]:
        count = Counter(words)
        return [word for word, _ in sorted(count.items(), key=lambda item: (-item[1], item[0]))[:k]]