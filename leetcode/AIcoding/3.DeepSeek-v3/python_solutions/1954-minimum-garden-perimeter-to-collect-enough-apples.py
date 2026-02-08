class Solution:
    def minimumPerimeter(self, neededApples: int) -> int:
        left, right = 1, 100000
        answer = 0
        while left <= right:
            mid = (left + right) // 2
            total = 2 * mid * (mid + 1) * (2 * mid + 1)
            if total >= neededApples:
                answer = mid
                right = mid - 1
            else:
                left = mid + 1
        return answer * 8