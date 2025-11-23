from collections import Counter

class Solution:
    def isPossibleDivide(self, nums: list[int], k: int) -> bool:
        if len(nums) % k != 0:
            return False

        count = Counter(nums)

        for num in sorted(count.keys()):
            if count[num] > 0:
                for i in range(k):
                    if count[num + i] == 0:
                        return False
                    count[num + i] -= count[num]
                    if count[num + i] < 0:
                        return False

        return True