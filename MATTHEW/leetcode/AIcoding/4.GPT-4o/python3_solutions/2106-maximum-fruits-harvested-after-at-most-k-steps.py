class Solution:
    def maxFruits(self, fruits: List[int], startPos: int, k: int) -> int:
        n = len(fruits)
        total_fruits = 0
        left = startPos
        right = startPos
        current_fruits = 0

        while right < n and right - startPos <= k:
            current_fruits += fruits[right]
            right += 1

        total_fruits = current_fruits

        while left > 0 or right > 0:
            if left > 0 and (startPos - left) <= k:
                left -= 1
                current_fruits += fruits[left]
            elif right < n and (right - startPos) <= k:
                current_fruits += fruits[right]
                right += 1
            else:
                break

            total_fruits = max(total_fruits, current_fruits)

        return total_fruits