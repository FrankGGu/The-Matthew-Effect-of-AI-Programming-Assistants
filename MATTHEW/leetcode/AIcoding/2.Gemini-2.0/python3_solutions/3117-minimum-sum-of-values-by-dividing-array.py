class Solution:
    def minimumSum(self, nums: List[int], k: int) -> int:
        s = set()
        ans = 0
        i = 1
        while len(s) < k:
            if i not in s and i in nums:
                s.add(i)
                ans += i
            elif i not in s:
                s.add(i)
                ans += i
            i += 1
        return ans