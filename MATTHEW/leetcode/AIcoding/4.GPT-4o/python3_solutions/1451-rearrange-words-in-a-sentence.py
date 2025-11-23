def arrangeWords(self, text: str) -> str:
    words = text.split()
    words.sort(key=lambda x: len(x))
    return ' '.join(words).lower().capitalize()