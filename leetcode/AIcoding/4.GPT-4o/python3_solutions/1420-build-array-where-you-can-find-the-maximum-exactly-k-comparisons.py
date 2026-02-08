def maxArray(K: int, N: int) -> List[int]:
    result = []
    for i in range(N, 0, -1):
        if K > 0:
            result.append(i)
            K -= 1
        else:
            result.append(1)
    return result[::-1]