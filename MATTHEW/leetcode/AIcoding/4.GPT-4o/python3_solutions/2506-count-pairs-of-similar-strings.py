class Solution:
    def similarPairs(self, words: List[str]) -> int:
        def encode(word):
            return frozenset(word)

        encoded_words = defaultdict(int)
        for word in words:
            encoded_words[encode(word)] += 1

        count = 0
        for freq in encoded_words.values():
            count += freq * (freq - 1) // 2

        return count