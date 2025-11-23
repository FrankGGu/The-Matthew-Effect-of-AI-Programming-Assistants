class Solution:
    def minimumPerimeter(self, neededApples: int) -> int:
        k = 0
        current_apples = 0
        while current_apples < neededApples:
            k += 1
            current_apples = 2 * (2 * k + 1) * k * (k + 1)

        return 8 * k