from collections import Counter

class Solution:
    def canDivideIntoSets(self, nums: List[int], k: int) -> bool:
        if len(nums) % k != 0:
            return False

        count = Counter(nums)
        for num in sorted(count):
            if count[num] > 0:
                for i in range(num, num + k):
                    if count[i] < count[num]:
                        return False
                    count[i] -= count[num]
        return True