class Solution:
    def supplyWagon(self, supplies: list[int], k: int) -> list[int]:
        n = len(supplies)
        while n > 2 * k:
            min_sum = float('inf')
            min_index = -1
            for i in range(n - 1):
                current_sum = supplies[i] + supplies[i + 1]
                if current_sum < min_sum:
                    min_sum = current_sum
                    min_index = i

            supplies[min_index] = supplies[min_index] + supplies[min_index + 1]
            supplies.pop(min_index + 1)
            n -= 1

        return supplies