class Solution:
    def toGoatLatin(self, sentence: str) -> str:
        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        words = sentence.split()
        result_words = []

        for i, word in enumerate(words):
            first_char = word[0]
            modified_word = ""

            if first_char in vowels:
                modified_word = word + "ma"
            else:
                modified_word = word[1:] + first_char + "ma"

            modified_word += 'a' * (i + 1)
            result_words.append(modified_word)

        return " ".join(result_words)