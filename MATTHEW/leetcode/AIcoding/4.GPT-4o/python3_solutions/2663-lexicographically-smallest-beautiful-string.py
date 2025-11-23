def smallestBeautifulString(s: str, k: int) -> str:
    s = list(s)
    n = len(s)

    def is_beautiful(s):
        for i in range(2, len(s)):
            if s[i] == s[i - 1] == s[i - 2]:
                return False
            if i > 0 and s[i] == s[i - 1]:
                return False
        return True

    for i in range(n - 1, -1, -1):
        if s[i] < chr(ord('a') + k - 1):
            s[i] = chr(ord(s[i]) + 1)
            for j in range(i + 1, n):
                s[j] = 'a'
            if is_beautiful(s):
                return ''.join(s)
        else:
            s[i] = 'a'

    return '' if n == 0 else 'a' + 'a' * (n - 1)