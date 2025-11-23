from collections import Counter

class Solution:
    def frequencySort(self, s: str) -> str:
        count = Counter(s)
        return ''.join(char * freq for char, freq in count.most_common())