class Solution:
    def uncommonFromSentences(self, A: str, B: str) -> List[str]:
        from collections import defaultdict

        word_count = defaultdict(int)
        for word in A.split():
            word_count[word] += 1
        for word in B.split():
            word_count[word] += 1

        return [word for word in word_count if word_count[word] == 1]