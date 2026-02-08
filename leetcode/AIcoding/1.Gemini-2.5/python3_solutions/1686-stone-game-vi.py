from typing import List

class Solution:
    def stoneGameVI(self, aliceValues: List[int], bobValues: List[int]) -> int:
        n = len(aliceValues)

        stones_info = []
        for i in range(n):
            stones_info.append((aliceValues[i] + bobValues[i], i))

        stones_info.sort(key=lambda x: x[0], reverse=True)

        alice_score = 0
        bob_score = 0

        for i in range(n):
            original_idx = stones_info[i][1]
            if i % 2 == 0:  # Alice's turn
                alice_score += aliceValues[original_idx]
            else:  # Bob's turn
                bob_score += bobValues[original_idx]

        if alice_score > bob_score:
            return 1
        elif alice_score < bob_score:
            return -1
        else:
            return 0