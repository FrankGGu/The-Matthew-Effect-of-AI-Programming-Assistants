def decrypt(code, k):
    n = len(code)
    if k == 0:
        return [0] * n
    result = [0] * n
    if k > 0:
        total = sum(code[i] for i in range(k))
        for i in range(n):
            result[i] = total
            total += code[(i + k) % n] - code[i]
    else:
        total = sum(code[i] for i in range(n + k, n))
        for i in range(n):
            result[i] = total
            total += code[(i - 1) % n] - code[(i + k) % n]
    return result