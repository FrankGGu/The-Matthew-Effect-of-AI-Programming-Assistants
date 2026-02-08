class Solution:
    def maxDistance(self, position: List[int], m: int) -> int:
        position.sort()
        left, right = 1, position[-1] - position[0]
        answer = 0

        def canPlace(d):
            count = 1
            last = position[0]
            for i in range(1, len(position)):
                if position[i] - last >= d:
                    count += 1
                    last = position[i]
                    if count == m:
                        return True
            return count >= m

        while left <= right:
            mid = left + (right - left) // 2
            if canPlace(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer