import collections

class Solution:
    def similarPairs(self, words: list[str]) -> int:
        canonical_forms = []
        for word in words:
            canonical_forms.append(frozenset(word))

        counts = collections.Counter(canonical_forms)

        total_pairs = 0
        for count in counts.values():
            if count >= 2:
                total_pairs += (count * (count - 1)) // 2

        return total_pairs