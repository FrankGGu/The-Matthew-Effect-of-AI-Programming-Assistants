class Solution:
    def countValidWords(self, sentence: str) -> int:
        def is_valid_word(word: str) -> bool:
            if not word:
                return False

            hyphen_count = 0
            punctuation_count = 0

            for i, char in enumerate(word):
                if char.isdigit():
                    return False

                if char == '-':
                    hyphen_count += 1
                    if hyphen_count > 1:
                        return False

                    # Hyphen must not be at the beginning or end of the word
                    if i == 0 or i == len(word) - 1:
                        return False

                    # Hyphen must be surrounded by lowercase letters
                    if not word[i-1].islower() or not word[i+1].islower():
                        return False

                elif char in "!.,":
                    punctuation_count += 1
                    if punctuation_count > 1:
                        return False

                    # Punctuation mark must be at the end of the word
                    if i != len(word) - 1:
                        return False

                # Any other character must be a lowercase letter
                elif not char.islower():
                    return False

            return True

        valid_words_count = 0
        tokens = sentence.split()

        for token in tokens:
            if is_valid_word(token):
                valid_words_count += 1

        return valid_words_count