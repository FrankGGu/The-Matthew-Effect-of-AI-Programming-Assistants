import heapq

class Solution:
    def earliestSecondToMarkIndices(self, nums: list[int], changeIndices: list[int]) -> int:
        n = len(nums)
        m = len(changeIndices)

        def check(time):
            last_occ = [-1] * n
            for i in range(time):
                last_occ[changeIndices[i] - 1] = i

            if any(x == -1 for x in last_occ):
                return False

            available = 0
            marked = [False] * n

            for i in range(time):
                idx = changeIndices[i] - 1
                if i == last_occ[idx]:
                    if available >= nums[idx]:
                        available -= nums[idx]
                        marked[idx] = True
                    else:
                        return False
                else:
                    available += 1

            return all(marked)

        left, right = 1, m
        ans = -1
        while left <= right:
            mid = (left + right) // 2
            if check(mid):
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans