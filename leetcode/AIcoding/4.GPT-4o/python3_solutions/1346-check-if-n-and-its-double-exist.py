class Solution:
    def checkIfExist(self, arr: List[int]) -> bool:
        num_set = set(arr)
        for num in arr:
            if num * 2 in num_set and num != 0:
                return True
        return False