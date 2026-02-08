class Solution:
    def earliestSecondToMarkIndices(self, nums: List[int], changeIndices: List[int]) -> int:
        n = len(nums)
        m = len(changeIndices)
        left = 1
        right = m
        answer = -1

        def is_possible(s):
            last = {}
            for i in range(s):
                idx = changeIndices[i] - 1
                if 0 <= idx < n:
                    last[idx] = i
            if len(last) != n:
                return False
            total = 0
            for i in range(s):
                idx = changeIndices[i] - 1
                if i == last[idx]:
                    if nums[idx] > total:
                        return False
                    total -= nums[idx]
                else:
                    total += 1
            return True

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                answer = mid
                right = mid - 1
            else:
                left = mid + 1
        return answer