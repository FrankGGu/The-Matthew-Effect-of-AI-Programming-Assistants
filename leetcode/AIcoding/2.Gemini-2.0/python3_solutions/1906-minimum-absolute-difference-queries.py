class Solution:
    def minDifference(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums)
        prefix = [[] for _ in range(101)]
        for i in range(n):
            prefix[nums[i]].append(i)

        ans = []
        for start, end in queries:
            min_diff = float('inf')
            prev = -1
            for val in range(1, 101):
                left = 0
                right = len(prefix[val]) - 1
                idx = -1
                while left <= right:
                    mid = (left + right) // 2
                    if prefix[val][mid] >= start:
                        idx = prefix[val][mid]
                        right = mid - 1
                    else:
                        left = mid + 1

                if idx != -1 and idx <= end:
                    if prev != -1:
                        min_diff = min(min_diff, val - prev)
                    prev = val

            if min_diff == float('inf'):
                ans.append(-1)
            else:
                ans.append(min_diff)

        return ans