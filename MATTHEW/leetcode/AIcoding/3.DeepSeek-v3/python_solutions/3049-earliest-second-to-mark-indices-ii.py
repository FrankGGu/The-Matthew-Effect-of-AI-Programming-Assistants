class Solution:
    def earliestSecondToMarkIndices(self, nums: List[int], changeIndices: List[int]) -> int:
        n = len(nums)
        m = len(changeIndices)
        left = 1
        right = m
        answer = -1

        while left <= right:
            mid = (left + right) // 2
            last_occurrence = {}
            for s in range(mid):
                idx = changeIndices[s] - 1
                last_occurrence[idx] = s

            if len(last_occurrence) != n:
                left = mid + 1
                continue

            total_operations = 0
            valid = True
            for s in range(mid):
                idx = changeIndices[s] - 1
                if last_occurrence[idx] == s:
                    if total_operations < nums[idx]:
                        valid = False
                        break
                    total_operations -= nums[idx]
                else:
                    total_operations += 1

            if valid:
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return answer