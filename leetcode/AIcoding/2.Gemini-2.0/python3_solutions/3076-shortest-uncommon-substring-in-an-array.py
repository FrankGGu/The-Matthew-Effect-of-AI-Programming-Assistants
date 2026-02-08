def shortest_uncommon_substring(arr):
    def get_substrings(s):
        substrings = set()
        for i in range(len(s)):
            for j in range(i, len(s)):
                substrings.add(s[i:j + 1])
        return substrings

    def is_uncommon(substring, arr):
        for s in arr:
            if substring in s:
                return False
        return True

    all_substrings = set()
    for s in arr:
        all_substrings.update(get_substrings(s))

    min_len = float('inf')
    result = ""

    for length in range(1, 101):
        for s in arr:
            for i in range(len(s) - length + 1):
                substring = s[i:i + length]
                if is_uncommon(substring, arr):
                    if length < min_len:
                        min_len = length
                        result = substring
                    return result

    return ""