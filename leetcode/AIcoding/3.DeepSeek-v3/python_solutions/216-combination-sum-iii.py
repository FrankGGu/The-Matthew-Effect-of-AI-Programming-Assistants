class Solution:
    def combinationSum3(self, k: int, n: int) -> List[List[int]]:
        res = []

        def backtrack(start, path, target):
            if len(path) == k and target == 0:
                res.append(path.copy())
                return
            if len(path) >= k or target <= 0:
                return
            for num in range(start, 10):
                path.append(num)
                backtrack(num + 1, path, target - num)
                path.pop()

        backtrack(1, [], n)
        return res