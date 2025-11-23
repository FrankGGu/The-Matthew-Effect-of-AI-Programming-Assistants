class Solution:
    def maxNumberOfGroups(self, actual: List[int]) -> int:
        actual.sort()
        groups = 0
        count = 0
        for num in actual:
            if num > count:
                groups += 1
                count += 1
        return groups