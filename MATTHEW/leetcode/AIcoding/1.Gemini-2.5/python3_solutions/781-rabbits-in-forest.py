import collections

class Solution:
    def numRabbits(self, answers: list[int]) -> int:
        if not answers:
            return 0

        counts = collections.Counter(answers)
        total_rabbits = 0

        for answer_val, freq in counts.items():
            num_groups = (freq + answer_val) // (answer_val + 1)
            total_rabbits += num_groups * (answer_val + 1)

        return total_rabbits