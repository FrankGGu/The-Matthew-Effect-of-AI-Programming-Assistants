def findTheDifference(s: str, t: str) -> str:
    from collections import Counter
    return (Counter(t) - Counter(s)).most_common(1)[0][0]