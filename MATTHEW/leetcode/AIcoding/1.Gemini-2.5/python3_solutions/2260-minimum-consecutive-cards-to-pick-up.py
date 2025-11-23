import math

class Solution:
    def minimumCardPickup(self, cards: list[int]) -> int:
        card_map = {}
        min_len = math.inf

        for i, card in enumerate(cards):
            if card in card_map:
                last_idx = card_map[card]
                current_len = i - last_idx + 1
                min_len = min(min_len, current_len)
            card_map[card] = i

        if min_len == math.inf:
            return -1
        else:
            return min_len