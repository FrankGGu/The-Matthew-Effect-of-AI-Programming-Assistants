import collections

class Solution:
    def isNStraightHand(self, hand: list[int], k: int) -> bool:
        n = len(hand)
        if n % k != 0:
            return False

        if k == 1:
            return True

        counts = collections.Counter(hand)

        sorted_unique_cards = sorted(counts.keys())

        for card in sorted_unique_cards:
            if counts[card] > 0:
                num_sequences = counts[card]

                for i in range(k):
                    current_card = card + i
                    if counts[current_card] < num_sequences:
                        return False
                    counts[current_card] -= num_sequences

        return True