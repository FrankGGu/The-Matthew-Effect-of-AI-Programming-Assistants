def uncommonFromSentences(A: str, B: str) -> List[str]:
    from collections import Counter
    count = Counter(A.split() + B.split())
    return [word for word, freq in count.items() if freq == 1]