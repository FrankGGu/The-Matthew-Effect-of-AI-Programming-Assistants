def commonChars(A):
    result = list(A[0])
    for word in A[1:]:
        result = [c for c in result if c in word]
        for c in set(result):
            result.remove(c)
            result.extend([c] * min(word.count(c), A[0].count(c) if c in A[0] else 0))
    return result