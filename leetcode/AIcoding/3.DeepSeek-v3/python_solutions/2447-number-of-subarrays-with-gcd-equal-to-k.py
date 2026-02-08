class Solution:
    def subarrayGCD(self, nums: List[int], k: int) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            current_gcd = nums[i]
            for j in range(i, n):
                current_gcd = math.gcd(current_gcd, nums[j])
                if current_gcd == k:
                    count += 1
                elif current_gcd < k:
                    break
        return count