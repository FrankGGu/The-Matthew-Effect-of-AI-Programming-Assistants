import collections

class Solution:
    def isNStraightHand(self, hand: list[int], groupSize: int) -> bool:
        n = len(hand)
        if n % groupSize != 0:
            return False

        counts = collections.Counter(hand)

        sorted_unique_cards = sorted(counts.keys())

        for card in sorted_unique_cards:
            if counts[card] == 0:
                continue

            num_straights_to_form = counts[card]

            for i in range(card, card + groupSize):
                if counts[i] < num_straights_to_form:
                    return False

                counts[i] -= num_straights_to_form

        return True