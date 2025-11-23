class Solution:
    def isSumEqual(self, firstWord: str, secondWord: str, targetWord: str) -> bool:
        def word_to_int(word: str) -> int:
            num_str = ""
            for char_code in word:
                num_str += str(ord(char_code) - ord('a'))
            return int(num_str)

        val1 = word_to_int(firstWord)
        val2 = word_to_int(secondWord)
        val_target = word_to_int(targetWord)

        return val1 + val2 == val_target