class Solution:
    def stoneGameVI(self, aliceValues: list[int], bobValues: list[int]) -> int:
        n = len(aliceValues)
        values = []
        for i in range(n):
            values.append((aliceValues[i] + bobValues[i], aliceValues[i], bobValues[i]))

        values.sort(reverse=True)

        alice_score = 0
        bob_score = 0

        for i in range(n):
            if i % 2 == 0:
                alice_score += values[i][1]
            else:
                bob_score += values[i][2]

        if alice_score > bob_score:
            return 1
        elif alice_score < bob_score:
            return -1
        else:
            return 0