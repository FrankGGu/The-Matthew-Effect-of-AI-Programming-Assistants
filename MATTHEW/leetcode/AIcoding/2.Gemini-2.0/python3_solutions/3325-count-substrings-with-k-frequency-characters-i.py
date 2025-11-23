def count_substrings(s: str, k: int) -> int:
    n = len(s)
    count = 0
    for i in range(n):
        for j in range(i, n):
            sub = s[i:j+1]
            freq = {}
            for char in sub:
                freq[char] = freq.get(char, 0) + 1

            has_k = False
            for char in freq:
                if freq[char] == k:
                    has_k = True
                    break

            if has_k:
                count += 1
    return count