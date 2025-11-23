class Solution:
    def makeEqual(self, words: List[str]) -> bool:
        from collections import Counter
        count = Counter()
        for word in words:
            count.update(word)
        return all(v % len(words) == 0 for v in count.values())