def diStringMatch(s: str) -> List[int]:
    n = len(s)
    low, high = 0, n
    result = []

    for char in s:
        if char == 'I':
            result.append(low)
            low += 1
        else:
            result.append(high)
            high -= 1

    result.append(low)  # or result.append(high), both are the same here
    return result