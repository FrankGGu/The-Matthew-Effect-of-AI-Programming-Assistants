class Solution:
    def canAliceWin(self, nums1: list[int], nums2: list[int]) -> bool:
        n = len(nums1)

        nums1.sort()
        nums2.sort()

        # Calculate maximum wins for Player 1 (Alice)
        # Alice tries to maximize her wins by matching her cards optimally.
        # She uses her smallest available card to beat the opponent's smallest available card if possible.
        # If her current smallest card cannot win, she "discards" it by moving to the next,
        # effectively using it in a losing match to save stronger cards.
        alice_max_wins = 0
        i = 0  # Pointer for nums1
        j = 0  # Pointer for nums2
        while i < n and j < n:
            if nums1[i] > nums2[j]:
                alice_max_wins += 1
                i += 1
                j += 1
            else:
                # nums1[i] cannot beat nums2[j]. Since nums2 is sorted,
                # nums1[i] also cannot beat any nums2[k] where k > j.
                # To maximize wins, Alice should move to a potentially stronger card nums1[i+1].
                # This effectively means nums1[i] is used in a non-winning match.
                i += 1

        # Calculate maximum wins for Player 2 (Opponent)
        # The opponent also plays optimally to maximize their wins.
        # They use their smallest available card to beat Alice's smallest available card if possible.
        # If their current smallest card cannot win, they "discard" it by moving to the next.
        opponent_max_wins = 0
        i = 0  # Pointer for nums1
        j = 0  # Pointer for nums2
        while i < n and j < n:
            if nums2[j] > nums1[i]:
                opponent_max_wins += 1
                i += 1
                j += 1
            else:
                # nums2[j] cannot beat nums1[i]. Since nums1 is sorted,
                # nums2[j] also cannot beat any nums1[k] where k > i.
                # To maximize wins, the opponent should move to a potentially stronger card nums2[j+1].
                # This effectively means nums2[j] is used in a non-winning match.
                j += 1

        # Alice wins if she has strictly more points than her opponent.
        # If the scores are tied, her opponent wins.
        return alice_max_wins > opponent_max_wins