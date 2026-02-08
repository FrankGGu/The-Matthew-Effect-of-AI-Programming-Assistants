def wordPattern(pattern: str, s: str) -> bool:
    words = s.split()
    if len(pattern) != len(words):
        return False
    mapping = {}
    mapped = set()
    for p, w in zip(pattern, words):
        if p in mapping:
            if mapping[p] != w:
                return False
        else:
            if w in mapped:
                return False
            mapping[p] = w
            mapped.add(w)
    return True