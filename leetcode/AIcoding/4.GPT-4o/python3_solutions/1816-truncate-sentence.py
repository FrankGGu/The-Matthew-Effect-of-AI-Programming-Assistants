def truncateSentence(s: str, k: int) -> str:
    return ' '.join(s.split()[:k])