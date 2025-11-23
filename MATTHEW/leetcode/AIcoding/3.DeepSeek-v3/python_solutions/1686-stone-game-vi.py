class Solution:
    def stoneGameVI(self, aliceValues: List[int], bobValues: List[int]) -> int:
        n = len(aliceValues)
        stones = []
        for i in range(n):
            stones.append((aliceValues[i] + bobValues[i], aliceValues[i], bobValues[i]))
        stones.sort(reverse=True)

        alice = 0
        bob = 0
        for i in range(n):
            if i % 2 == 0:
                alice += stones[i][1]
            else:
                bob += stones[i][2]

        if alice > bob:
            return 1
        elif alice < bob:
            return -1
        else:
            return 0