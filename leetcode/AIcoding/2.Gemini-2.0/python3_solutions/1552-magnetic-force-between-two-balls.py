class Solution:
    def maxDistance(self, position: list[int], m: int) -> int:
        position.sort()
        l, r = 1, position[-1] - position[0]
        ans = 0
        while l <= r:
            mid = (l + r) // 2
            count = 1
            last = position[0]
            for i in range(1, len(position)):
                if position[i] - last >= mid:
                    count += 1
                    last = position[i]
            if count >= m:
                ans = mid
                l = mid + 1
            else:
                r = mid - 1
        return ans