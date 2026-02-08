def findTheLongestValidSubstring(word: str, forbidden: List[str]) -> int:
    forbidden_set = set(forbidden)
    max_length = 0
    n = len(word)

    left = 0
    while left < n:
        right = left
        while right < n and word[left:right+1] not in forbidden_set:
            max_length = max(max_length, right - left + 1)
            right += 1
        left += 1

    return max_length