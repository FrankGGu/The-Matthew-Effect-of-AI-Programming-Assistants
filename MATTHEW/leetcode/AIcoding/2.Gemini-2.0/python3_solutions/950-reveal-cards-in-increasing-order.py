class Solution:
    def deckRevealedIncreasing(self, deck: List[int]) -> List[int]:
        n = len(deck)
        deck.sort()
        res = [0] * n
        idx = list(range(n))
        for card in deck:
            res[idx.pop(0)] = card
            if idx:
                idx.append(idx.pop(0))
        return res