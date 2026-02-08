def take_k_of_each_character(s: str, k: int) -> int:
    n = len(s)
    count = {'a': 0, 'b': 0, 'c': 0}
    for char in s:
        count[char] += 1

    if count['a'] < k or count['b'] < k or count['c'] < k:
        return -1

    l, r = 0, 0
    curr_count = {'a': 0, 'b': 0, 'c': 0}
    max_len = 0

    while r < n:
        curr_count[s[r]] += 1

        while curr_count['a'] > count['a'] - k or \
              curr_count['b'] > count['b'] - k or \
              curr_count['c'] > count['c'] - k:
            curr_count[s[l]] -= 1
            l += 1

        max_len = max(max_len, r - l + 1)
        r += 1

    return n - max_len