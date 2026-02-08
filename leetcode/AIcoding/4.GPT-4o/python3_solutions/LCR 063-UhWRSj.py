class Solution:
    def replaceWords(self, dictionary: List[str], sentence: str) -> str:
        dictionary_set = set(dictionary)
        words = sentence.split()
        for i in range(len(words)):
            for root in sorted(dictionary_set, key=len):
                if words[i].startswith(root):
                    words[i] = root
                    break
        return ' '.join(words)