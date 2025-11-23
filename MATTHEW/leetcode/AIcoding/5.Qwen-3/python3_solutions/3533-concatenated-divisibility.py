class Solution:
    def isDivisible(self, nums: List[int], m: int) -> bool:
        from itertools import permutations

        for perm in permutations(nums):
            s = ""
            for num in perm:
                s += str(num)
            if int(s) % m == 0:
                return True
        return False