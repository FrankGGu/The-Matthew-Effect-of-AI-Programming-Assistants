class Solution:
    def mostFrequentID(self, ids: List[int]) -> List[int]:
        from collections import Counter
        count = Counter(ids)
        max_freq = max(count.values())
        return sorted([id_ for id_, freq in count.items() if freq == max_freq])