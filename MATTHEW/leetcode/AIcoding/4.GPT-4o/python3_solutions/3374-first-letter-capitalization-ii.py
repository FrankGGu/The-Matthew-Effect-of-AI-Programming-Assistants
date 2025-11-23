def capitalizeTitle(title: str) -> str:
    words = title.split()
    for i in range(len(words)):
        if len(words[i]) > 2:
            words[i] = words[i].capitalize()
        else:
            words[i] = words[i].lower()
    return ' '.join(words)