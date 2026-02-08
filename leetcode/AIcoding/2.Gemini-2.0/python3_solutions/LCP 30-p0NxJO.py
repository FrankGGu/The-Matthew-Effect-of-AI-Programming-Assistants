import heapq

class Solution:
    def magicTower(self, nums: list[int]) -> int:
        hp = 1
        neg_nums = []
        total_sum = sum(nums)
        if total_sum + hp <= 0:
            return -1

        ans = 0
        curr_sum = 0

        for num in nums:
            curr_sum += num
            if num < 0:
                heapq.heappush(neg_nums, num)

            while hp + curr_sum <= 0:
                smallest_neg = heapq.heappop(neg_nums)
                curr_sum -= smallest_neg
                hp += smallest_neg
                ans += 1

            hp += num

        return ans