def substringXorQueries(s: str, queries: list[list[int]]) -> list[int]:
    n = len(s)
    seen = {}
    for i in range(n):
        for j in range(i, min(i + 32, n)):
            sub = s[i:j+1]
            if sub[0] == '0' and len(sub) > 1:
                continue
            val = int(sub, 2)
            if val not in seen:
                seen[val] = [i, j]

    result = []
    for first, second in queries:
        xor_val = first ^ second
        if xor_val in seen:
            result.append(seen[xor_val])
        else:
            result.append([-1, -1])
    return result