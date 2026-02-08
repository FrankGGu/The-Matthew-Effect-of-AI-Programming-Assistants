import math

class Solution:
    def numSquarefulPerms(self, nums: list[int]) -> int:
        n = len(nums)
        nums.sort()

        self.count = 0
        self.used = [False] * n

        def is_perfect_square(num):
            sqrt_num = int(math.sqrt(num))
            return sqrt_num * sqrt_num == num

        def backtrack(current_permutation):
            if len(current_permutation) == n:
                self.count += 1
                return

            for i in range(n):
                if self.used[i]:
                    continue

                if i > 0 and nums[i] == nums[i-1] and not self.used[i-1]:
                    continue

                if current_permutation:
                    if not is_perfect_square(current_permutation[-1] + nums[i]):
                        continue

                self.used[i] = True
                current_permutation.append(nums[i])

                backtrack(current_permutation)

                current_permutation.pop()
                self.used[i] = False

        backtrack([])
        return self.count