def takeCharacters(s: str, k: int) -> int:
    from collections import Counter

    count = Counter(s)
    if any(count[char] < k for char in set(s)):
        return len(s)

    left = 0
    result = len(s)

    for right in range(len(s)):
        count[s[right]] -= 1

        while all(count[char] <= k for char in set(s)):
            result = min(result, right - left + 1)
            count[s[left]] += 1
            left += 1

    return result