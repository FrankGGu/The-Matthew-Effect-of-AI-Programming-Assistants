import heapq

class Solution:
    def magicTower(self, nums: List[int]) -> int:
        if sum(nums) < 0:
            return -1

        hp = []
        curr_hp = 1
        res = 0
        total = 0

        for num in nums:
            curr_hp += num
            total += num
            if num < 0:
                heapq.heappush(hp, num)
            if curr_hp <= 0:
                res += 1
                min_num = heapq.heappop(hp)
                curr_hp -= min_num

        return res