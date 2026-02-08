class Solution:
    def numRabbits(self, answers: list[int]) -> int:
        count = {}
        for ans in answers:
            if ans not in count:
                count[ans] = 0
            count[ans] += 1

        res = 0
        for key, val in count.items():
            group_size = key + 1
            num_groups = (val + group_size - 1) // group_size
            res += num_groups * group_size

        return res