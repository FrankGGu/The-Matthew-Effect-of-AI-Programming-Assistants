class Solution:
    def subarrayLCM(self, nums: List[int], k: int) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            current_lcm = nums[i]
            if current_lcm == k:
                count += 1
            for j in range(i + 1, n):
                current_lcm = self.lcm(current_lcm, nums[j])
                if current_lcm == k:
                    count += 1
                elif current_lcm > k:
                    break
        return count

    def lcm(self, a: int, b: int) -> int:
        return a * b // self.gcd(a, b)

    def gcd(self, a: int, b: int) -> int:
        while b:
            a, b = b, a % b
        return a