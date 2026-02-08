def minNumberOfValidStrings(target: str, words: List[str]) -> int:
    from collections import Counter

    target_count = Counter(target)
    word_count = [Counter(word) for word in words]

    def can_form(counts):
        for char, cnt in target_count.items():
            if counts[char] < cnt:
                return False
        return True

    def backtrack(start, counts, used):
        if can_form(counts):
            return 0
        min_count = float('inf')
        for i in range(start, len(words)):
            if not used[i]:
                used[i] = True
                for char, cnt in word_count[i].items():
                    counts[char] += cnt
                min_count = min(min_count, 1 + backtrack(i + 1, counts, used))
                used[i] = False
                for char, cnt in word_count[i].items():
                    counts[char] -= cnt
        return min_count

    used = [False] * len(words)
    result = backtrack(0, Counter(), used)
    return result if result != float('inf') else -1