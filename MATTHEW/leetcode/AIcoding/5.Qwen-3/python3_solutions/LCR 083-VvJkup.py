class Solution:
    def permute(self, nums):
        result = []
        self.backtrack(nums, [], result)
        return result

    def backtrack(self, nums, path, result):
        if len(path) == len(nums):
            result.append(path[:])
            return
        for num in nums:
            if num not in path:
                path.append(num)
                self.backtrack(nums, path, result)
                path.pop()