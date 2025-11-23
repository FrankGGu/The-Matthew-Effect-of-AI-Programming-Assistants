def getSmallestString(n: int, k: int) -> str:
    result = []
    for i in range(n):
        if k > 26:
            result.append('z')
            k -= 26
        else:
            result.append(chr(ord('a') + k - 1))
            k -= k - 1
    result = result[::-1]
    return ''.join(result)