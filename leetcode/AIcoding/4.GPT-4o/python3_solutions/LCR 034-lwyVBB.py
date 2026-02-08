def isAlienSorted(words: List[str], order: str) -> bool:
    order_index = {char: idx for idx, char in enumerate(order)}
    def alien_compare(word1, word2):
        for c1, c2 in zip(word1, word2):
            if order_index[c1] < order_index[c2]:
                return -1
            elif order_index[c1] > order_index[c2]:
                return 1
        return len(word1) - len(word2)

    for i in range(len(words) - 1):
        if alien_compare(words[i], words[i + 1]) > 0:
            return False
    return True