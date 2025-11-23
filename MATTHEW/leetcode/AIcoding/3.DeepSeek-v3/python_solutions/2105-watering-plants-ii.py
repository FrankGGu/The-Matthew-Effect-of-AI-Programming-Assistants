class Solution:
    def minimumRefill(self, plants: List[int], capacityA: int, capacityB: int) -> int:
        n = len(plants)
        left = 0
        right = n - 1
        refill = 0
        currentA = capacityA
        currentB = capacityB

        while left <= right:
            if left == right:
                if max(currentA, currentB) < plants[left]:
                    refill += 1
                break
            if currentA < plants[left]:
                refill += 1
                currentA = capacityA
            currentA -= plants[left]
            left += 1

            if currentB < plants[right]:
                refill += 1
                currentB = capacityB
            currentB -= plants[right]
            right -= 1

        return refill