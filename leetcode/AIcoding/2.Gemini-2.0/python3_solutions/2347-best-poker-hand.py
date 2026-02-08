class Solution:
    def bestHand(self, ranks: list[int], suits: list[str]) -> str:
        if len(set(suits)) == 1:
            return "Flush"

        rank_counts = {}
        for rank in ranks:
            rank_counts[rank] = rank_counts.get(rank, 0) + 1

        max_count = 0
        for count in rank_counts.values():
            max_count = max(max_count, count)

        if max_count >= 3:
            return "Three of a Kind"
        elif max_count == 2:
            return "Pair"
        else:
            return "High Card"