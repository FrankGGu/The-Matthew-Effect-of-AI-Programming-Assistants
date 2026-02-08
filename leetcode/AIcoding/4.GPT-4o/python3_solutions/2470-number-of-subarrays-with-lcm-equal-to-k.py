class Solution:
    def subarrayLCM(self, nums: List[int], k: int) -> int:
        def lcm(a, b):
            return a * b // math.gcd(a, b)

        count = 0
        n = len(nums)

        for i in range(n):
            current_lcm = 1
            for j in range(i, n):
                current_lcm = lcm(current_lcm, nums[j])
                if current_lcm > k:
                    break
                if current_lcm == k:
                    count += 1

        return count