def minWindow(s: str, t: str) -> str:
    if not t or not s:
        return ""

    dict_t = {}
    for char in t:
        dict_t[char] = dict_t.get(char, 0) + 1

    required = len(dict_t)
    formed = 0

    window_counts = {}

    left, right = 0, 0

    ans = float('inf'), None, None

    while right < len(s):
        character = s[right]
        window_counts[character] = window_counts.get(character, 0) + 1

        if character in dict_t and window_counts[character] == dict_t[character]:
            formed += 1

        while left <= right and formed == required:
            character = s[left]

            if right - left + 1 < ans[0]:
                ans = (right - left + 1, left, right)

            window_counts[character] -= 1
            if character in dict_t and window_counts[character] < dict_t[character]:
                formed -= 1

            left += 1

        right += 1

    return "" if ans[0] == float('inf') else s[ans[1] : ans[2] + 1]