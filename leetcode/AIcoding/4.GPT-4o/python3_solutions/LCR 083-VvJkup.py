class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        res = []
        def backtrack(path, options):
            if not options:
                res.append(path)
                return
            for i in range(len(options)):
                backtrack(path + [options[i]], options[:i] + options[i+1:])
        backtrack([], nums)
        return res