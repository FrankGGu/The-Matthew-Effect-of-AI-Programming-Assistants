class Solution:
    def findValidSplit(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        prime_count = defaultdict(int)
        for num in nums:
            i = 2
            temp = num
            while i * i <= temp:
                while temp % i == 0:
                    prime_count[i] += 1
                    temp //= i
                i += 1
            if temp > 1:
                prime_count[temp] += 1

        left_count = defaultdict(int)
        right_count = prime_count.copy()

        for i in range(n):
            num = nums[i]
            j = 2
            temp = num
            while j * j <= temp:
                while temp % j == 0:
                    left_count[j] += 1
                    right_count[j] -= 1
                    temp //= j
                j += 1
            if temp > 1:
                left_count[temp] += 1
                right_count[temp] -= 1

            valid = True
            for p in left_count:
                if left_count[p] != right_count[p]:
                    valid = False
                    break
            if valid:
                return i

        return -1