class Solution:
    def isCovered(self, ranges: List[List[int]], left: int, right: int) -> bool:
        covered = [0] * 52
        for start, end in ranges:
            covered[start] += 1
            covered[end + 1] -= 1
        for i in range(1, 52):
            covered[i] += covered[i - 1]
        return all(covered[i] > 0 for i in range(left, right + 1))