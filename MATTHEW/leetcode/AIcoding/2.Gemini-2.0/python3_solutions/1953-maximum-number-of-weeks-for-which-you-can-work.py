class Solution:
    def numberOfWeeks(self, milestones: list[int]) -> int:
        max_milestone = max(milestones)
        total_sum = sum(milestones)
        remaining_sum = total_sum - max_milestone

        if max_milestone > remaining_sum:
            return 2 * remaining_sum + 1
        else:
            return total_sum