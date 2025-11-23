class Solution:
    def minimumCardPickup(self, cards: list[int]) -> int:
        last_seen = {}
        min_length = float('inf')
        for i, card in enumerate(cards):
            if card in last_seen:
                length = i - last_seen[card] + 1
                min_length = min(min_length, length)
            last_seen[card] = i
        return min_length if min_length != float('inf') else -1