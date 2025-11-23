class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        order_index = {char: idx for idx, char in enumerate(order)}

        for i in range(len(words) - 1):
            word1 = words[i]
            word2 = words[i + 1]

            for j in range(min(len(word1), len(word2))):
                char1 = word1[j]
                char2 = word2[j]

                if char1 != char2:
                    if order_index[char1] > order_index[char2]:
                        return False
                    break

        return True