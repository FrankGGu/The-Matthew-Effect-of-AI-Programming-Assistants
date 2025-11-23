class Solution:
    def uniqueOccurrences(self, arr: List[int]) -> bool:
        freq = {}
        for num in arr:
            freq[num] = freq.get(num, 0) + 1
        occurrences = freq.values()
        return len(occurrences) == len(set(occurrences))