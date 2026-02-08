class Solution:
    def minimumCardPickup(self, cards: List[int]) -> int:
        card_index = {}
        min_length = float('inf')

        for i, card in enumerate(cards):
            if card in card_index:
                min_length = min(min_length, i - card_index[card] + 1)
            card_index[card] = i

        return min_length if min_length != float('inf') else -1