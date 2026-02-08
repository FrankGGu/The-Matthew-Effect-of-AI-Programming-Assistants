def longestNewString(s: str) -> str:
    from collections import Counter

    count = Counter(s)
    result = []

    for char in sorted(count.keys()):
        result.append(char * (count[char] // 2))

    half_string = ''.join(result)
    full_string = half_string + ''.join(sorted(set(s) - set(half_string)))

    return full_string + full_string[::-1]