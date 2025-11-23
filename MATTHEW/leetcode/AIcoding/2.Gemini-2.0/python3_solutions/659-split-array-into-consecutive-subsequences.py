import heapq

class Solution:
    def isPossible(self, nums: list[int]) -> bool:
        tails = {}
        for num in nums:
            if num - 1 in tails and tails[num - 1] > 0:
                tails[num - 1] -= 1
                if tails[num - 1] == 0:
                    del tails[num - 1]
                tails[num] = tails.get(num, 0) + 1
            else:
                if num + 1 in nums and num + 2 in nums:
                    tails[num + 2] = tails.get(num + 2, 0) + 1
                    nums.remove(num + 1)
                    nums.remove(num + 2)
                else:
                    return False
        return True