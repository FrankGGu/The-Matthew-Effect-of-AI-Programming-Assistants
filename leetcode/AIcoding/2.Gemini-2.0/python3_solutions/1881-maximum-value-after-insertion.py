class Solution:
    def maxValueAfterInsertion(self, n: str, x: int) -> str:
        if n[0] == '-':
            for i in range(len(n)):
                if int(n[i]) > x:
                    return n[:i] + str(x) + n[i:]
            return n + str(x)
        else:
            for i in range(len(n)):
                if int(n[i]) < x:
                    return n[:i] + str(x) + n[i:]
            return n + str(x)