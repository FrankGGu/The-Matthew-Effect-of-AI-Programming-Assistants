class Solution:
    def capitalizeTitle(self, title: str) -> str:
        words = title.split()
        result_words = []
        for word in words:
            lower_word = word.lower()
            if len(lower_word) <= 2:
                result_words.append(lower_word)
            else:
                result_words.append(lower_word.capitalize())
        return " ".join(result_words)