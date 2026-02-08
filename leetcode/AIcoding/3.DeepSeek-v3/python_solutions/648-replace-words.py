class Solution:
    def replaceWords(self, dictionary: List[str], sentence: str) -> str:
        roots = set(dictionary)
        words = sentence.split()
        for i in range(len(words)):
            word = words[i]
            for j in range(1, len(word) + 1):
                prefix = word[:j]
                if prefix in roots:
                    words[i] = prefix
                    break
        return ' '.join(words)