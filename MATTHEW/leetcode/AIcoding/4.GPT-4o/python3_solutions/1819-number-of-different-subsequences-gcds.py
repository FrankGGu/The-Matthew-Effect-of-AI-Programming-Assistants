class Solution:
    def countDifferentSubsequenceGCDs(self, nums: List[int]) -> int:
        max_num = max(nums)
        present = [0] * (max_num + 1)
        for num in nums:
            present[num] = 1

        gcd_set = set()

        for g in range(1, max_num + 1):
            current_gcd = 0
            for multiple in range(g, max_num + 1, g):
                if present[multiple]:
                    current_gcd = math.gcd(current_gcd, multiple)
            if current_gcd == g:
                gcd_set.add(g)

        return len(gcd_set)