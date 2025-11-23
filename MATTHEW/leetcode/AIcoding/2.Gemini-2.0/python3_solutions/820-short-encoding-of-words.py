class Solution:
    def minimumLengthEncoding(self, words: list[str]) -> int:
        words = sorted(list(set(words)), key=len, reverse=True)
        good = set()
        for i, word in enumerate(words):
            if word in good:
                continue
            for j in range(i + 1, len(words)):
                if words[j].endswith(word):
                    good.add(word)
                    break
        return sum(len(word) + 1 for word in words if word not in good)