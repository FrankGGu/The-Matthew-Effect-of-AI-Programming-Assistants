from collections import defaultdict

class Solution:
    def groupThePeople(self, groupSizes: list[int]) -> list[list[int]]:
        result = []
        temp_groups = defaultdict(list)

        for i in range(len(groupSizes)):
            size = groupSizes[i]
            temp_groups[size].append(i)

            if len(temp_groups[size]) == size:
                result.append(temp_groups[size])
                temp_groups[size] = []

        return result