class Solution:
    def beautifulIndices(self, nums: str, s: str, k: int) -> List[int]:
        indices = []
        n = len(nums)
        m = len(s)
        for i in range(n - m + 1):
            if nums[i:i+m] == s:
                indices.append(i)
        result = []
        for i in indices:
            valid = True
            for j in indices:
                if i != j and abs(i - j) <= k:
                    valid = False
                    break
            if valid:
                result.append(i)
        return result