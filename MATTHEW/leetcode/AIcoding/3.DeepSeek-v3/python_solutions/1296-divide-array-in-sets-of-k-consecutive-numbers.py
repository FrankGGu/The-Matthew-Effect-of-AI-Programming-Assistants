import collections

class Solution:
    def isPossibleDivide(self, nums: List[int], k: int) -> bool:
        if len(nums) % k != 0:
            return False

        count = collections.Counter(nums)
        sorted_keys = sorted(count.keys())

        for num in sorted_keys:
            if count[num] > 0:
                needed = count[num]
                for i in range(num, num + k):
                    if count[i] < needed:
                        return False
                    count[i] -= needed
        return True