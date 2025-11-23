class Solution:
    def maximumNumberOfAlloys(self, n: int, k: int, target: int, materials: List[int], alloys: List[List[int]]) -> int:
        def can_produce(m):
            for i in range(n):
                total = 0
                for j in range(n):
                    total += alloys[j][i] * m
                if total > materials[i]:
                    return False
            return True

        left, right = 0, 10**18
        answer = 0
        while left <= right:
            mid = (left + right) // 2
            if can_produce(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer