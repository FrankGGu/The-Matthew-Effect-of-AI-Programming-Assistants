class Solution:
    def removeAnagrams(self, words: List[str]) -> List[str]:
        result = []
        prev_sorted = ""
        for word in words:
            sorted_word = ''.join(sorted(word))
            if sorted_word != prev_sorted:
                result.append(word)
                prev_sorted = sorted_word
        return result