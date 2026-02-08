import collections

class Solution:
    def frequencySort(self, s: str) -> str:
        counts = collections.Counter(s)

        sorted_items = sorted(counts.items(), key=lambda item: item[1], reverse=True)

        result = []
        for char, freq in sorted_items:
            result.append(char * freq)

        return "".join(result)