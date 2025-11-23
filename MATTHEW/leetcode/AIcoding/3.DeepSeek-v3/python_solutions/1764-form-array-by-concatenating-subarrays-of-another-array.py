class Solution:
    def canChoose(self, groups: List[List[int]], nums: List[int]) -> bool:
        i = 0
        n = len(nums)
        for group in groups:
            found = False
            gl = len(group)
            while i + gl <= n:
                if nums[i:i+gl] == group:
                    found = True
                    i += gl
                    break
                i += 1
            if not found:
                return False
        return True