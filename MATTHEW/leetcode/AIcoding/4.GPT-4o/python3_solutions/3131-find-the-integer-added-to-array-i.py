class Solution:
    def findTheInteger(self, arr: List[int]) -> int:
        num_set = set(arr)
        for num in arr:
            if num + 1 not in num_set:
                return num + 1
        return -1