def alternatingGroups(a: List[int]) -> List[int]:
    n = len(a)
    result = []
    for i in range(n):
        if i % 2 == 0:
            result.append(a[i])
    return result