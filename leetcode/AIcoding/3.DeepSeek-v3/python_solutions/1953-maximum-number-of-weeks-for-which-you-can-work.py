class Solution:
    def numberOfWeeks(self, milestones: List[int]) -> int:
        max_milestone = max(milestones)
        total = sum(milestones)
        rest = total - max_milestone

        if max_milestone <= rest + 1:
            return total
        else:
            return 2 * rest + 1