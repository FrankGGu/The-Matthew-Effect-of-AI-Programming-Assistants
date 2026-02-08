from collections import deque

class Solution:
    def advantageCount(self, A: List[int], B: List[int]) -> List[int]:
        A.sort()
        B_sorted = sorted((b, i) for i, b in enumerate(B))
        result = [0] * len(A)
        available = deque()

        for a in A:
            if a > B_sorted[0][0]:
                result[B_sorted.popleft()[1]] = a
            else:
                available.append(a)

        for i in range(len(result)):
            if result[i] == 0:
                result[i] = available.popleft()

        return result