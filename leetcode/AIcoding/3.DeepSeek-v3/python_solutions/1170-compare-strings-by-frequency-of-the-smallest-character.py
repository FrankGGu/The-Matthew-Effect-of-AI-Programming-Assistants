class Solution:
    def numSmallerByFrequency(self, queries: List[str], words: List[str]) -> List[int]:
        def f(s):
            if not s:
                return 0
            smallest_char = min(s)
            return s.count(smallest_char)

        word_freq = [f(word) for word in words]
        word_freq.sort()
        res = []
        for query in queries:
            query_freq = f(query)
            left, right = 0, len(word_freq)
            while left < right:
                mid = (left + right) // 2
                if word_freq[mid] > query_freq:
                    right = mid
                else:
                    left = mid + 1
            res.append(len(word_freq) - left)
        return res