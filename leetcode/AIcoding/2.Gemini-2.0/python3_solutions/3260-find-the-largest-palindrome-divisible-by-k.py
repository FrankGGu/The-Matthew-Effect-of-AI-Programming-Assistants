def largestPalindrome(n: int, k: int) -> str:
    if n == 1:
        return str(k - 1) if k <= 10 else "-1"

    upper_bound = 10 ** n - 1
    lower_bound = 10 ** (n - 1)

    for i in range(upper_bound, lower_bound - 1, -1):
        if i % k == 0:
            s = str(i)
            half = s[:(n + 1) // 2]
            if n % 2 == 0:
                palindrome = half + half[::-1]
            else:
                palindrome = half + half[:-1][::-1]

            if int(palindrome) % k == 0 and lower_bound <= int(palindrome) <= upper_bound:
                 return palindrome
    return "-1"