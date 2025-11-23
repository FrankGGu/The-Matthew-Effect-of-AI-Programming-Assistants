class Solution:
    def isCircularArrayLoop(self, nums: List[int]) -> bool:
        n = len(nums)
        for i in range(n):
            if not nums[i]:
                continue
            direction = nums[i] > 0
            slow, fast = i, i
            while True:
                slow = (slow + nums[slow]) % n
                if (nums[slow] > 0) != direction or nums[slow] == 0:
                    break
                fast = (fast + nums[fast]) % n
                if (nums[fast] > 0) != direction or nums[fast] == 0:
                    break
                fast = (fast + nums[fast]) % n
                if (nums[fast] > 0) != direction or nums[fast] == 0:
                    break
                if slow == fast:
                    if slow == (slow + nums[slow]) % n:
                        break
                    return True
            val = nums[i]
            while True:
                next_index = (i + nums[i]) % n
                if nums[i] * val <= 0:
                    break
                nums[i] = 0
                i = next_index
        return False