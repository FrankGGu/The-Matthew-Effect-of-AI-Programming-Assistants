import collections

class Solution:
    def canReorderDoubled(self, arr: list[int]) -> bool:
        count = collections.Counter(arr)

        sorted_keys = sorted(count.keys(), key=abs)

        for x in sorted_keys:
            if count[x] == 0:
                continue

            if x == 0:
                if count[0] % 2 != 0:
                    return False
                count[0] = 0
                continue

            if count[2 * x] < count[x]:
                return False

            count[2 * x] -= count[x]
            count[x] = 0

        return True