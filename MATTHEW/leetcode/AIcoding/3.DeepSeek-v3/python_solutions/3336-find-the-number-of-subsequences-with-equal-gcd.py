class Solution:
    def countSubsequences(self, nums: List[int]) -> int:
        max_num = max(nums) if nums else 0
        count = [0] * (max_num + 1)
        mod = 10**9 + 7

        for num in nums:
            temp = count.copy()
            temp[num] += 1
            for g in range(1, max_num + 1):
                if count[g]:
                    new_gcd = math.gcd(g, num)
                    temp[new_gcd] += count[g]
                    temp[new_gcd] %= mod
            count = temp

        return count[1] % mod