def findOriginalString(s: str) -> str:
    n = len(s)
    original = ""
    i = 0
    while i < n:
        j = i + 1
        while j <= n and s[i:j].isdigit():
            j += 1

        if j == i + 1:
            original += s[i]
            i += 1
        else:
            j -= 1
            num_str = s[i:j]
            num = int(num_str)
            original = original[:-num]
            i = j
    return original