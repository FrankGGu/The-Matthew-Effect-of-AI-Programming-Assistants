class Solution:
    def minimumCardPickup(self, cards: List[int]) -> int:
        last_seen = {}
        min_cards = float('inf')

        for i, card in enumerate(cards):
            if card in last_seen:
                min_cards = min(min_cards, i - last_seen[card] + 1)
            last_seen[card] = i

        return min_cards if min_cards != float('inf') else -1