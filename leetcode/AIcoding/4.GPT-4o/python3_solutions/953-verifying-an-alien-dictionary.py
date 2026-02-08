def isAlienSorted(words: List[str], order: str) -> bool:
    order_index = {char: index for index, char in enumerate(order)}

    def translate(word):
        return [order_index[char] for char in word]

    translated_words = [translate(word) for word in words]

    return all(translated_words[i] <= translated_words[i + 1] for i in range(len(translated_words) - 1))