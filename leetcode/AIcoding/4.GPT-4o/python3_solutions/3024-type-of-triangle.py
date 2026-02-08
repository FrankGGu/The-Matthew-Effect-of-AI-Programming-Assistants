def triangleType(a: int, b: int, c: int) -> int:
    if a <= 0 or b <= 0 or c <= 0:
        return 0
    if a + b <= c or a + c <= b or b + c <= a:
        return 0
    if a == b == c:
        return 1
    if a == b or b == c or a == c:
        return 2
    return 3