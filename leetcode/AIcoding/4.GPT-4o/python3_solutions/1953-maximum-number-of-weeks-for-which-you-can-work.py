class Solution:
    def maxWeeks(self, milestones: List[int]) -> int:
        total = sum(milestones)
        max_milestone = max(milestones)
        if total - max_milestone < max_milestone:
            return total * 2 - 1
        return total