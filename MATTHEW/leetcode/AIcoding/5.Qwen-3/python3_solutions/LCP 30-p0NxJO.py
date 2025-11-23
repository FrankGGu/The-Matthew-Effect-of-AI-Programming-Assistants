class Solution:
    def magicTower(self, nums: List[int]) -> int:
        from collections import deque

        nums = deque(nums)
        hp = 1
        steps = 0
        while nums:
            if hp <= 0:
                return -1
            if nums[0] > 0:
                hp += nums.popleft()
            else:
                if hp > abs(nums[0]):
                    hp += nums.popleft()
                else:
                    steps += 1
                    nums.append(nums.popleft())
        return steps