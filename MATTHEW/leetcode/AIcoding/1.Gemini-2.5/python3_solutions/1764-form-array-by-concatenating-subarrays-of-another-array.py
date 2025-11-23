class Solution:
    def canChoose(self, groups: list[list[int]], nums: list[int]) -> bool:

        current_nums_idx = 0

        for group in groups:
            found_group_in_nums = False

            for j in range(current_nums_idx, len(nums) - len(group) + 1):
                if nums[j : j + len(group)] == group:
                    found_group_in_nums = True
                    current_nums_idx = j + len(group)
                    break

            if not found_group_in_nums:
                return False

        return True