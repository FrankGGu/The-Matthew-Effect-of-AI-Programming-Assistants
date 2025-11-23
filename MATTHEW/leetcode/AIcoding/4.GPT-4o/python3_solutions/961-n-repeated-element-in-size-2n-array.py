class Solution:
    def repeatedNTimes(self, A: List[int]) -> int:
        count = {}
        for num in A:
            if num in count:
                return num
            count[num] = 1