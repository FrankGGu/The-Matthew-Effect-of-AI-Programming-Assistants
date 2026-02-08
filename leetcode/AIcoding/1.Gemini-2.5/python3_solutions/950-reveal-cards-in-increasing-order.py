import collections

class Solution:
    def deckRevealedIncreasing(self, deck: list[int]) -> list[int]:
        n = len(deck)
        deck.sort()  # Sort the deck in increasing order

        ans = [0] * n  # Initialize the result array

        # Create a deque of indices (0, 1, ..., n-1).
        # These indices represent the positions in the 'ans' array where cards will be placed.
        # The order in the deque simulates the reveal process in reverse.
        indices = collections.deque(range(n))

        for card in deck:
            # The current smallest card from the sorted deck is placed at the
            # position that would be revealed next.
            idx_to_place = indices.popleft()
            ans[idx_to_place] = card

            # If there are still positions left to fill, simulate moving the next card
            # to the bottom of the deck by taking the next index from the front
            # and putting it at the back of the queue of available indices.
            if indices:
                indices.append(indices.popleft())

        return ans