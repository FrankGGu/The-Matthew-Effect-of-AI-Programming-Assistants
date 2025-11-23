def sum_of_largest_prime_substrings(s: str) -> int:
    def is_prime(n: int) -> bool:
        if n < 2:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True

    n = len(s)
    ans = 0
    for i in range(n):
        for j in range(i, n):
            sub = s[i:j+1]
            if sub[0] == '0' and len(sub) > 1:
                continue
            num = int(sub)
            if is_prime(num) and num <= 1000:
                ans += num
    return ans