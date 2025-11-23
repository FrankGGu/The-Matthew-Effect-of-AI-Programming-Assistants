def findSpecialSubstring(s: str, k: int) -> int:
    n = len(s)
    count = 0
    for i in range(n - k + 1):
        substring = s[i:i+k]
        distinct_chars = set(substring)
        if len(distinct_chars) == 1:
            count += 1
    return count