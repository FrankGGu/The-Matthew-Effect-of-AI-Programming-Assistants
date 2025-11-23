class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        tails = []
        for num in nums:
            if not tails or num > tails[-1]:
                tails.append(num)
            else:
                l, r = 0, len(tails) - 1
                while l <= r:
                    mid = (l + r) // 2
                    if tails[mid] < num:
                        l = mid + 1
                    else:
                        r = mid - 1
                tails[l] = num
        return len(tails)