def shortest_matching_substring(source, target):
    if not source or not target:
        return ""

    n = len(source)
    m = len(target)
    if m > n:
        return ""

    min_len = float('inf')
    start_index = -1

    target_freq = {}
    for char in target:
        target_freq[char] = target_freq.get(char, 0) + 1

    window_freq = {}
    left = 0
    matched = 0

    for right in range(n):
        char = source[right]
        window_freq[char] = window_freq.get(char, 0) + 1

        if char in target_freq and window_freq[char] == target_freq[char]:
            matched += 1

        while matched == len(target_freq):
            if right - left + 1 < min_len:
                min_len = right - left + 1
                start_index = left

            left_char = source[left]
            window_freq[left_char] -= 1

            if left_char in target_freq and window_freq[left_char] < target_freq[left_char]:
                matched -= 1

            left += 1

    if start_index == -1:
        return ""

    return source[start_index:start_index + min_len]