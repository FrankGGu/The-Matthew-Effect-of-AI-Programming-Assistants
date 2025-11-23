class Solution:
    def numSmallerByFrequency(self, queries: List[str], words: List[str]) -> List[int]:
        def frequency(s: str) -> int:
            return s.count(min(s))

        word_freqs = sorted(frequency(word) for word in words)
        result = []

        for query in queries:
            query_freq = frequency(query)
            count = len([w for w in word_freqs if w > query_freq])
            result.append(count)

        return result