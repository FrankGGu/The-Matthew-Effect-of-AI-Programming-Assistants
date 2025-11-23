from collections import Counter

class Solution:
    def isNStraightHand(self, hand: List[int], W: int) -> bool:
        if len(hand) % W != 0:
            return False

        hand.sort()
        count = Counter(hand)

        for card in hand:
            if count[card] > 0:
                for i in range(W):
                    if count[card + i] <= 0:
                        return False
                    count[card + i] -= 1

        return True