import math

class Solution:
    def flipgame(self, fronts: list[int], backs: list[int]) -> int:
        same_sided_numbers = set()
        for i in range(len(fronts)):
            if fronts[i] == backs[i]:
                same_sided_numbers.add(fronts[i])

        min_good_integer = math.inf

        for num in fronts:
            if num not in same_sided_numbers:
                min_good_integer = min(min_good_integer, num)

        for num in backs:
            if num not in same_sided_numbers:
                min_good_integer = min(min_good_integer, num)

        if min_good_integer == math.inf:
            return 0
        else:
            return int(min_good_integer)