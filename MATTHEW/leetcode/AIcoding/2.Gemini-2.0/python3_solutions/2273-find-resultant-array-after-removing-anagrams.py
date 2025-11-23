class Solution:
    def removeAnagrams(self, words: list[str]) -> list[str]:
        result = []
        last_sorted = ""
        for word in words:
            sorted_word = "".join(sorted(word))
            if sorted_word != last_sorted:
                result.append(word)
                last_sorted = sorted_word
        return result