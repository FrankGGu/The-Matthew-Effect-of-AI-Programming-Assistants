import collections

class Solution:
    def bestHand(self, ranks: list[int], suits: list[str]) -> str:
        if len(set(suits)) == 1:
            return "Flush"

        rank_counts = collections.Counter(ranks)

        max_freq = 0
        for count in rank_counts.values():
            if count > max_freq:
                max_freq = count

        if max_freq >= 3:
            return "Three of a Kind"
        elif max_freq == 2:
            return "Pair"
        else:
            return "High Card"