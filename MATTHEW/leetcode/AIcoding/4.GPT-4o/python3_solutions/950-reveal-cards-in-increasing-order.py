from collections import deque

class Solution:
    def deckRevealedIncreasing(self, deck: List[int]) -> List[int]:
        deck.sort()
        result = deque()
        for card in reversed(deck):
            if result:
                result.appendleft(result.pop())
            result.appendleft(card)
        return list(result)