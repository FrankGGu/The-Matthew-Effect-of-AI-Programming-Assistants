class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        order_map = {c: i for i, c in enumerate(order)}

        for i in range(len(words) - 1):
            word1 = words[i]
            word2 = words[i+1]

            min_len = min(len(word1), len(word2))

            for j in range(min_len):
                if order_map[word1[j]] < order_map[word2[j]]:
                    break
                elif order_map[word1[j]] > order_map[word2[j]]:
                    return False
            else:
                if len(word1) > len(word2):
                    return False

        return True