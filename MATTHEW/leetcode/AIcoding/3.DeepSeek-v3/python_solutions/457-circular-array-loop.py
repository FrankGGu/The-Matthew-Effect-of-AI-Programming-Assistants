class Solution:
    def circularArrayLoop(self, nums: List[int]) -> bool:
        n = len(nums)
        for i in range(n):
            if nums[i] == 0:
                continue
            slow = i
            fast = self.next(nums, i)
            while nums[slow] * nums[fast] > 0 and nums[slow] * nums[self.next(nums, fast)] > 0:
                if slow == fast:
                    if slow == self.next(nums, slow):
                        break
                    return True
                slow = self.next(nums, slow)
                fast = self.next(nums, self.next(nums, fast))
            slow = i
            while nums[slow] * nums[self.next(nums, slow)] > 0:
                temp = slow
                slow = self.next(nums, slow)
                nums[temp] = 0
        return False

    def next(self, nums: List[int], i: int) -> int:
        n = len(nums)
        return (i + nums[i]) % n