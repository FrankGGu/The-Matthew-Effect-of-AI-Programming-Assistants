class Solution:
    def minimumRefill(self, plants: List[int], capacityA: int, capacityB: int) -> int:
        n = len(plants)
        refills = 0
        a, b = capacityA, capacityB

        for i in range(n):
            if i % 2 == 0:  # Person A's turn
                if a < plants[i]:
                    refills += 1
                    a = capacityA
                a -= plants[i]
            else:  # Person B's turn
                if b < plants[i]:
                    refills += 1
                    b = capacityB
                b -= plants[i]

        return refills