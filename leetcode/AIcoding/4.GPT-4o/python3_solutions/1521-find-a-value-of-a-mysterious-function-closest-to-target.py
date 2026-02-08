class Solution:
    def closestToTarget(self, arr: List[int], target: int) -> int:
        closest = float('inf')
        n = len(arr)

        for i in range(n):
            current = arr[i]
            closest = min(closest, abs(current - target))
            for j in range(i + 1, n):
                current &= arr[j]
                closest = min(closest, abs(current - target))
                if current < target:
                    break

        return closest