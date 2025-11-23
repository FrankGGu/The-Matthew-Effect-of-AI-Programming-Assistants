class Solution:
    def bestHand(self, ranks: List[int]) -> str:
        counter = Counter(ranks)
        max_count = max(counter.values())

        if max_count >= 3:
            return "Three of a Kind"
        elif max_count == 2:
            return "One Pair"
        else:
            return "High Card"