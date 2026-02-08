class Solution:
    def areSentencesSimilar(self, sentence1: str, sentence2: str) -> bool:
        s1 = sentence1.split()
        s2 = sentence2.split()
        n1 = len(s1)
        n2 = len(s2)
        i = 0
        j = 0
        while i < n1 and i < n2 and s1[i] == s2[i]:
            i += 1
        while j < n1 - i and j < n2 - i and s1[n1 - 1 - j] == s2[n2 - 1 - j]:
            j += 1
        return i + j == min(n1, n2)