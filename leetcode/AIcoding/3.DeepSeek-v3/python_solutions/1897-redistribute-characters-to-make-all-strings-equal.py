class Solution:
    def makeEqual(self, words: List[str]) -> bool:
        from collections import defaultdict
        char_count = defaultdict(int)
        n = len(words)
        for word in words:
            for char in word:
                char_count[char] += 1
        for count in char_count.values():
            if count % n != 0:
                return False
        return True