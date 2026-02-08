def halvesAreAlike(s: str) -> bool:
    vowels = set('aeiouAEIOU')
    mid = len(s) // 2
    left = sum(1 for char in s[:mid] if char in vowels)
    right = sum(1 for char in s[mid:] if char in vowels)
    return left == right