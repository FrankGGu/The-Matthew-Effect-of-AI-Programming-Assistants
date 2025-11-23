class Solution:
    def meetRequirement(self, people: List[int], target: int) -> int:
        closest = -1
        min_diff = float('inf')
        for i in range(len(people)):
            diff = abs(people[i] - target)
            if diff < min_diff:
                min_diff = diff
                closest = i
        return closest