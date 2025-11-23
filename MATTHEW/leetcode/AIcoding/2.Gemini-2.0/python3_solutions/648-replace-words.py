class Solution:
    def replaceWords(self, dictionary: List[str], sentence: str) -> str:
        dictionary.sort()
        words = sentence.split()
        result = []
        for word in words:
            found = False
            for root in dictionary:
                if word.startswith(root):
                    result.append(root)
                    found = True
                    break
            if not found:
                result.append(word)
        return " ".join(result)