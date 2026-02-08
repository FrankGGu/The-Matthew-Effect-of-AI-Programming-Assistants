class Solution:
    def lengthOfLIS(self, nums: List[int], k: int) -> int:
        from sortedcontainers import SortedList

        sl = SortedList()
        for num in nums:
            if num <= k:
                idx = sl.bisect_right(num)
                if idx < len(sl):
                    sl[idx] = num
                else:
                    sl.add(num)
        return len(sl)