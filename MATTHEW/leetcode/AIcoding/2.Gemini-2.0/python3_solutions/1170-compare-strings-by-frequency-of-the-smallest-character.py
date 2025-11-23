def numSmallerByFrequency(queries, words):
    def f(s):
        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1
        min_char = min(counts.keys())
        return counts[min_char]

    freqs = [f(word) for word in words]
    result = []
    for query in queries:
        count = 0
        query_freq = f(query)
        for freq in freqs:
            if freq > query_freq:
                count += 1
        result.append(count)
    return result