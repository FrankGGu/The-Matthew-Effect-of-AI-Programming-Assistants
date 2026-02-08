import bisect

class Solution:
    def numSmallerByFrequency(self, queries: list[str], words: list[str]) -> list[int]:

        def calculate_f(s: str) -> int:
            smallest_char = min(s)
            return s.count(smallest_char)

        word_frequencies = []
        for word in words:
            word_frequencies.append(calculate_f(word))

        word_frequencies.sort()

        results = []
        for query_string in queries:
            query_freq = calculate_f(query_string)

            # Find the index where query_freq would be inserted to maintain order,
            # such that all elements to the right of this index are strictly greater.
            idx = bisect.bisect_right(word_frequencies, query_freq)

            count_greater = len(word_frequencies) - idx
            results.append(count_greater)

        return results