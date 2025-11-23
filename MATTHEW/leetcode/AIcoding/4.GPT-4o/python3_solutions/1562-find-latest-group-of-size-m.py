class Solution:
    def findLatestGroup(self, A: List[int], M: int) -> List[int]:
        from collections import defaultdict

        groups = defaultdict(list)

        for i in range(len(A)):
            groups[A[i]].append(i + 1)

        result = []
        for key in sorted(groups.keys()):
            if len(groups[key]) == M:
                result = groups[key]

        return result