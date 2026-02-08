def numMatchingSubseq(s: str, words: List[str]) -> int:
    from collections import defaultdict

    char_map = defaultdict(list)
    for index, char in enumerate(s):
        char_map[char].append(index)

    def is_subsequence(word):
        current_index = -1
        for char in word:
            if char not in char_map:
                return False
            positions = char_map[char]
            next_index = bisect.bisect_right(positions, current_index)
            if next_index == len(positions):
                return False
            current_index = positions[next_index]
        return True

    return sum(1 for word in words if is_subsequence(word))