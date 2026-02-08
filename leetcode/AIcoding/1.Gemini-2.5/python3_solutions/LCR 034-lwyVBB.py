class Solution:
    def isAlienSorted(self, words: list[str], order: str) -> bool:
        order_map = {char: i for i, char in enumerate(order)}

        for i in range(len(words) - 1):
            word1 = words[i]
            word2 = words[i+1]

            # Assume words are equal until a difference is found or one ends
            words_are_equal_so_far = True 

            for j in range(min(len(word1), len(word2))):
                char1 = word1[j]
                char2 = word2[j]

                if order_map[char1] < order_map[char2]:
                    # word1 comes before word2, this pair is correctly sorted
                    words_are_equal_so_far = False
                    break
                elif order_map[char1] > order_map[char2]:
                    # word1 comes after word2, this pair is not sorted
                    return False
                # If order_map[char1] == order_map[char2], continue to the next character

            if words_are_equal_so_far and len(word1) > len(word2):
                # If all common prefix characters are the same,
                # the shorter word must come first.
                # If word1 is longer and word2 is a prefix of word1, it's unsorted.
                return False

        return True