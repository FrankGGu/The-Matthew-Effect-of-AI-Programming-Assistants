def canBeTypedWords(text: str, brokenLetters: str) -> int:
    words = text.split()
    broken_set = set(brokenLetters)
    count = 0

    for word in words:
        if not any(char in broken_set for char in word):
            count += 1

    return count