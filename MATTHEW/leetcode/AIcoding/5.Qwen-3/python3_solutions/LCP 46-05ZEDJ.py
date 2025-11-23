class Solution:
    def distributeVolunteers(self, volunteers: List[int], target: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        result = 0
        prefix_sum = 0

        count[0] = 1

        for vol in volunteers:
            prefix_sum += vol
            result += count[prefix_sum - target]
            count[prefix_sum] += 1

        return result