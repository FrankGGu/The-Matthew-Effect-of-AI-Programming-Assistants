class Solution:
    def findUniqueBinaryString(self, nums: List[str]) -> str:
        n = len(nums)
        seen = set(nums)

        def dfs(path, length):
            if length == n:
                return path if path not in seen else None
            for bit in ['0', '1']:
                result = dfs(path + bit, length + 1)
                if result:
                    return result
            return None

        return dfs("", 0)