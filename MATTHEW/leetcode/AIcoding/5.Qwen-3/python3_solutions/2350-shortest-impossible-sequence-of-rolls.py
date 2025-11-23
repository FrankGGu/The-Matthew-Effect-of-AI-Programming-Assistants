class Solution:
    def lengthOfSmallestSubsequence(self, rolls: List[int]) -> int:
        count = set()
        res = 0
        for num in rolls:
            if num not in count:
                count.add(num)
                if len(count) == 6:
                    res += 1
                    count.clear()
        return res + 1