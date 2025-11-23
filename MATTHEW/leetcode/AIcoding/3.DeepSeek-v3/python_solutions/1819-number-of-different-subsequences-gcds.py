class Solution:
    def countDifferentSubsequenceGCDs(self, nums: List[int]) -> int:
        max_num = max(nums) if nums else 0
        present = [False] * (max_num + 1)
        for num in nums:
            present[num] = True

        res = 0
        for x in range(1, max_num + 1):
            current_gcd = 0
            for multiple in range(x, max_num + 1, x):
                if present[multiple]:
                    if current_gcd == 0:
                        current_gcd = multiple
                    else:
                        current_gcd = self.gcd(current_gcd, multiple)
                    if current_gcd == x:
                        res += 1
                        break
        return res

    def gcd(self, a: int, b: int) -> int:
        while b:
            a, b = b, a % b
        return a