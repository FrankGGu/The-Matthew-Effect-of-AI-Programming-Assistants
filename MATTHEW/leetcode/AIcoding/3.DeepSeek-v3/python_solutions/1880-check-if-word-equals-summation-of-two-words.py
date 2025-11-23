class Solution:
    def isSumEqual(self, firstWord: str, secondWord: str, targetWord: str) -> bool:
        def word_to_num(word):
            num = 0
            for c in word:
                num = num * 10 + (ord(c) - ord('a'))
            return num

        first_num = word_to_num(firstWord)
        second_num = word_to_num(secondWord)
        target_num = word_to_num(targetWord)

        return first_num + second_num == target_num