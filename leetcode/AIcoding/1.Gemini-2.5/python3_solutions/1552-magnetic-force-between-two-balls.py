class Solution:
    def maxDistance(self, position: list[int], m: int) -> int:
        position.sort()
        n = len(position)

        def check(force):
            count = 1
            last_pos = position[0]
            for i in range(1, n):
                if position[i] - last_pos >= force:
                    count += 1
                    last_pos = position[i]
                    if count == m:
                        return True
            return count >= m

        low = 1
        high = position[-1] - position[0]
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans