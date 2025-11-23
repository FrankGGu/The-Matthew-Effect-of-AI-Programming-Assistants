class Solution:
    def wateringPlants(self, plants: List[int], capacityA: int, capacityB: int) -> int:
        n = len(plants)
        a = capacityA
        b = capacityB
        steps = 0
        left = 0
        right = n - 1

        while left < right:
            if a >= plants[left]:
                a -= plants[left]
                steps += 1
            else:
                a = capacityA
                a -= plants[left]
                steps += 1

            if b >= plants[right]:
                b -= plants[right]
                steps += 1
            else:
                b = capacityB
                b -= plants[right]
                steps += 1

            left += 1
            right -= 1

        if left == right:
            if a >= b:
                if a >= plants[left]:
                    steps += 1
                else:
                    steps += 1
            else:
                if b >= plants[left]:
                    steps += 1
                else:
                    steps += 1

        return steps