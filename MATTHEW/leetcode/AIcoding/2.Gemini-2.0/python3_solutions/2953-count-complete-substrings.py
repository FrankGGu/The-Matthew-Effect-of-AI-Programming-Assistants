def countCompleteSubstrings(word: str, k: int) -> int:
    n = len(word)
    count = 0
    for length in range(1, n + 1):
        for i in range(n - length + 1):
            sub = word[i:i + length]
            freq = {}
            complete = True
            for char in sub:
                freq[char] = freq.get(char, 0) + 1
            if len(freq) > 0:
                for char in freq:
                    if freq[char] != k:
                        complete = False
                        break
                if complete and len(freq) * k == length:
                    count += 1
    return count