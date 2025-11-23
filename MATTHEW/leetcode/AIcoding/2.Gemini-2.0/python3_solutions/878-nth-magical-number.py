def nthMagicalNumber(n: int, a: int, b: int) -> int:
    lcm = (a * b) // gcd(a, b)
    low = 0
    high = 10**15
    while low < high:
        mid = (low + high) // 2
        count = mid // a + mid // b - mid // lcm
        if count >= n:
            high = mid
        else:
            low = mid + 1
    return low % (10**9 + 7)

def gcd(a: int, b: int) -> int:
    while b:
        a, b = b, a % b
    return a