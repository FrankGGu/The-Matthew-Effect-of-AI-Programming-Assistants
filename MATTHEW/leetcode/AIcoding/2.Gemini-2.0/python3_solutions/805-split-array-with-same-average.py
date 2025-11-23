class Solution:
    def splitArraySameAverage(self, nums: List[int]) -> bool:
        n = len(nums)
        if n == 1:
            return False
        total_sum = sum(nums)

        for len_a in range(1, n // 2 + 1):
            target_sum = total_sum * len_a / n
            if abs(target_sum - int(target_sum)) > 1e-6:
                continue
            target_sum = int(target_sum)

            dp = set()
            dp.add(0)

            for num in nums:
                new_dp = set()
                for prev_sum in dp:
                    new_dp.add(prev_sum + num)
                dp.update(new_dp)

            if target_sum in dp:
                return True

        return False