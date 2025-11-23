class Solution:
    def maxDistance(self, position: List[int], m: int) -> int:
        position.sort()

        def can_place(d):
            count = 1
            last = position[0]
            for i in range(1, len(position)):
                if position[i] - last >= d:
                    count += 1
                    last = position[i]
                    if count == m:
                        return True
            return count >= m

        left, right = 1, position[-1] - position[0]
        result = 0
        while left <= right:
            mid = (left + right) // 2
            if can_place(mid):
                result = mid
                left = mid + 1
            else:
                right = mid - 1
        return result