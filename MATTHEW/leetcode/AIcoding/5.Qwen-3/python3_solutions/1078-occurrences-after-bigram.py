class Solution:
    def findOcurrences(self, text: str, bigram: str, target: str) -> List[str]:
        result = []
        words = text.split()
        for i in range(len(words) - 1):
            if words[i] == bigram[0] and words[i + 1] == bigram[1]:
                if i + 2 < len(words):
                    result.append(words[i + 2])
        return result