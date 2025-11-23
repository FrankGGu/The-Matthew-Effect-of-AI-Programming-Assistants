def reformatNumber(number: str) -> str:
    number = ''.join(filter(str.isdigit, number))
    n = len(number)
    parts = []

    i = 0
    while i < n:
        if n - i > 4:
            parts.append(number[i:i+3])
            i += 3
        else:
            parts.append(number[i:i+2])
            i += 2

    if len(parts[-1]) == 1:
        last_part = parts.pop()
        parts[-1] += last_part

    return '-'.join(parts)