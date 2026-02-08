class Solution:
    def concatenatedDivisibility(self, nums: List[int]) -> int:
        from itertools import permutations

        count = 0
        n = len(nums)
        seen = set()

        for p in permutations(nums):
            num_str = ''.join(map(str, p))
            if num_str in seen:
                continue
            seen.add(num_str)
            num = int(num_str)
            if num % n == 0:
                count += 1

        return count