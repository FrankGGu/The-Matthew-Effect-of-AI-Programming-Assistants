class Solution:
    def minimizeOr(self, nums: List[int]) -> int:
        res = 0
        for bit in range(30, -1, -1):
            mask = 1 << bit
            temp = res | mask
            cnt = 0
            curr_or = 0
            for num in nums:
                curr_or |= num & (~temp)
                if (num & temp) == temp:
                    cnt += 1
            if cnt > 0 and curr_or == 0:
                res = temp
        return res