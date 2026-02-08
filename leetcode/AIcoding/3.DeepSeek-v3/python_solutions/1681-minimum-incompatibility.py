class Solution:
    def minimumIncompatibility(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if k == n:
            return 0
        size = n // k
        count = collections.Counter(nums)
        if any(v > k for v in count.values()):
            return -1

        nums.sort()
        used = [False] * n
        self.res = float('inf')

        def backtrack(start, groups, prev, sum_diff):
            if len(groups) == k:
                self.res = min(self.res, sum_diff)
                return
            if sum_diff >= self.res:
                return
            if len(groups) < len(groups) + 1:
                for i in range(start, n):
                    if used[i]:
                        continue
                    if i > start and nums[i] == nums[i-1] and not used[i-1]:
                        continue
                    if len(groups) == 0 or (len(groups[-1]) < size and nums[i] > groups[-1][-1]):
                        if len(groups) == 0 or len(groups[-1]) < size:
                            if len(groups) == 0 or len(groups[-1]) == 0:
                                groups.append([nums[i]])
                            else:
                                groups[-1].append(nums[i])
                            used[i] = True
                            if len(groups[-1]) == size:
                                diff = groups[-1][-1] - groups[-1][0]
                                backtrack(0, groups, -1, sum_diff + diff)
                            else:
                                backtrack(i+1, groups, nums[i], sum_diff)
                            used[i] = False
                            if len(groups[-1]) == 1:
                                groups.pop()
                            else:
                                groups[-1].pop()

        backtrack(0, [], -1, 0)
        return self.res if self.res != float('inf') else -1