from collections import Counter

class Solution:
    def isStraightHand(self, hand: list[int], groupSize: int) -> bool:
        if len(hand) % groupSize != 0:
            return False

        count = Counter(hand)

        while count:
            min_val = min(count.keys())

            for i in range(min_val, min_val + groupSize):
                if count[i] == 0:
                    return False
                count[i] -= 1
                if count[i] == 0:
                    del count[i]

        return True