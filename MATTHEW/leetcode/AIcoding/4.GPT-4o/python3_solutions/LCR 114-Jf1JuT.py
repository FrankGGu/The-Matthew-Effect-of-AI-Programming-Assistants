class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        order_index = {char: index for index, char in enumerate(order)}
        def get_word_value(word):
            return [order_index[char] for char in word]

        for i in range(len(words) - 1):
            if get_word_value(words[i]) > get_word_value(words[i + 1]):
                return False
        return True