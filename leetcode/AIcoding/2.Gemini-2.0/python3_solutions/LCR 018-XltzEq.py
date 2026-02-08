def isPalindrome(s: str) -> bool:
    s = ''.join(ch for ch in s if ch.isalnum()).lower()
    l, r = 0, len(s) - 1
    while l < r:
        if s[l] != s[r]:
            return False
        l += 1
        r -= 1
    return True