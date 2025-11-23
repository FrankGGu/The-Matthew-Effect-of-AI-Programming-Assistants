def smallestBeautifulString(s: str, k: int) -> str:
    n = len(s)
    s = list(s)

    for i in range(n - 1, -1, -1):
        if s[i] < chr(ord('a') + k - 1):
            s[i] = chr(ord(s[i]) + 1)
            for j in range(i + 1, n):
                s[j] = 'a'
            if is_beautiful(s, k):
                return ''.join(s)

    return ""

def is_beautiful(s, k):
    for i in range(len(s)):
        if s[i] < 'a' or s[i] >= chr(ord('a') + k):
            return False
        if i > 1 and s[i] == s[i - 1] == s[i - 2]:
            return False
    return True