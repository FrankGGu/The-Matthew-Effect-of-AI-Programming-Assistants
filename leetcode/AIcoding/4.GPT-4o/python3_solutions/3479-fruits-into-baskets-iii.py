class Solution:
    def maxFruits(self, fruits: List[int], startPos: int, k: int) -> int:
        n = len(fruits)
        left, right = startPos, startPos
        total_fruits = 0
        fruit_count = 0

        while right < n and right - startPos <= k:
            fruit_count += fruits[right]
            right += 1

        total_fruits = fruit_count

        while left > 0 or right < n:
            if left > 0 and (startPos - left) <= k:
                left -= 1
                fruit_count += fruits[left]
            elif right < n and (right - startPos) <= k:
                fruit_count += fruits[right]
                right += 1
            else:
                break

            if left < startPos and (startPos - left) <= k:
                total_fruits = max(total_fruits, fruit_count)
            if right > startPos and (right - startPos) <= k:
                total_fruits = max(total_fruits, fruit_count)

        return total_fruits