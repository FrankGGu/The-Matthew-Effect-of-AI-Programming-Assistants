def findEncryptedString(s: str) -> str:
    n = len(s)
    if n == 0:
        return ""
    if n == 1:
        return s

    mid = n // 2
    left = findEncryptedString(s[:mid])
    right = findEncryptedString(s[mid + 1:])

    if left < right:
        return s[mid] + left + right
    else:
        return s[mid] + right + left