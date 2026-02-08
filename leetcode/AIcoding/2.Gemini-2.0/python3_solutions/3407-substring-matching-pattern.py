def is_substring_pattern(s: str, pattern: str) -> bool:
    n = len(s)
    m = len(pattern)

    if m == 0:
        return True

    if n == 0:
        return False

    for i in range(n - m + 1):
        match = True
        mapping = {}
        reverse_mapping = {}

        for j in range(m):
            char_s = s[i+j]
            char_p = pattern[j]

            if char_p not in mapping:
                if char_s in reverse_mapping:
                    match = False
                    break
                mapping[char_p] = char_s
                reverse_mapping[char_s] = char_p
            else:
                if mapping[char_p] != char_s:
                    match = False
                    break

        if match:
            return True

    return False