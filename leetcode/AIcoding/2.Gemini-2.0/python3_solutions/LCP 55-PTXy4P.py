class Solution:
    def maxTotalFruits(self, fruits: List[List[int]], startPos: int, k: int) -> int:
        left = 0
        right = 0
        max_fruits = 0
        current_fruits = 0

        while right < len(fruits):
            current_fruits += fruits[right][1]

            while (min(abs(fruits[right][0] - startPos), abs(fruits[left][0] - startPos)) + abs(fruits[right][0] - fruits[left][0])) > k:
                current_fruits -= fruits[left][1]
                left += 1

            max_fruits = max(max_fruits, current_fruits)
            right += 1

        return max_fruits