class Solution:
    def removeAnagrams(self, words: List[str]) -> List[str]:
        result = []
        prev = ""
        for word in words:
            current = ''.join(sorted(word))
            if current != prev:
                result.append(word)
                prev = current
        return result