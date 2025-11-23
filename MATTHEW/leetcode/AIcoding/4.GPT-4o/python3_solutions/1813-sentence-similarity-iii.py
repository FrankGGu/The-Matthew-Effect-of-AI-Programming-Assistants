class Solution:
    def areSentencesSimilar(self, sentence1: str, sentence2: str, similarPairs: List[List[str]]) -> bool:
        if len(sentence1) > len(sentence2):
            sentence1, sentence2 = sentence2, sentence1
        words1 = sentence1.split()
        words2 = sentence2.split()

        if len(words1) == len(words2):
            return all(w1 == w2 or (w1 in similar and w2 in similar[w1]) for w1, w2 in zip(words1, words2))

        if len(words1) < len(words2):
            for i in range(len(words1) + 1):
                if all(words1[j] == words2[j] or (words1[j] in similar and words2[j] in similar[words1[j]]) for j in range(len(words1))) and \
                   all(words2[j] in similar[words1[-1]] for j in range(i, len(words2))):
                    return True

        return False

    def build_similarity_map(self, similarPairs: List[List[str]]) -> Dict[str, Set[str]]:
        similar = defaultdict(set)
        for a, b in similarPairs:
            similar[a].add(b)
            similar[b].add(a)
        return similar