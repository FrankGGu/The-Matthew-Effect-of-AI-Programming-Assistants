class Solution:
    def isArraySpecial(self, nums: list[int], queries: list[list[int]]) -> list[bool]:
        n = len(nums)

        if n == 1:
            return [True] * len(queries)

        next_bad = [n] * n

        for i in range(n - 2, -1, -1):
            if (nums[i] % 2) == (nums[i+1] % 2):
                next_bad[i] = i
            else:
                next_bad[i] = next_bad[i+1]

        results = []
        for l, r in queries:
            if l == r:
                results.append(True)
                continue

            if next_bad[l] >= r:
                results.append(True)
            else:
                results.append(False)

        return results