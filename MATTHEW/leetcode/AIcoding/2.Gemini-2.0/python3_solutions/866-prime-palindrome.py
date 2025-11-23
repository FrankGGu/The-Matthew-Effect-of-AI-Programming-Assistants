def primePalindrome(n: int) -> int:
    def is_palindrome(num: int) -> bool:
        s = str(num)
        return s == s[::-1]

    def is_prime(num: int) -> bool:
        if num <= 1:
            return False
        for i in range(2, int(num**0.5) + 1):
            if num % i == 0:
                return False
        return True

    if n <= 2:
        return 2

    if 8 <= n <= 11:
        return 11

    length = len(str(n))

    while True:
        if length % 2 == 0:
            length += 1
            start = 10 ** ((length - 1) // 2)
        else:
            start = 10 ** ((length - 1) // 2)

        for i in range(start, 10 ** ((length + 1) // 2)):
            s = str(i)
            palindrome = int(s + s[:-1][::-1])
            if palindrome >= n and is_prime(palindrome):
                return palindrome
        length += 1