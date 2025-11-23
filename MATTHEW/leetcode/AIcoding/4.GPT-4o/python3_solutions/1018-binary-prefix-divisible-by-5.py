class Solution:
    def prefixesDivBy5(self, A: List[int]) -> List[bool]:
        result = []
        current = 0
        for num in A:
            current = (current << 1) | num
            result.append(current % 5 == 0)
        return result