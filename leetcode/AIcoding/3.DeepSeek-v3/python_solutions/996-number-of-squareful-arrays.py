import math
from collections import defaultdict

class Solution:
    def numSquarefulPerms(self, A: List[int]) -> int:
        A.sort()
        self.res = 0
        used = [False] * len(A)
        self.dfs(A, [], used)
        return self.res

    def dfs(self, A, path, used):
        if len(path) == len(A):
            self.res += 1
            return
        for i in range(len(A)):
            if used[i] or (i > 0 and A[i] == A[i-1] and not used[i-1]):
                continue
            if not path or self.isSquare(path[-1] + A[i]):
                used[i] = True
                self.dfs(A, path + [A[i]], used)
                used[i] = False

    def isSquare(self, num):
        root = math.isqrt(num)
        return root * root == num