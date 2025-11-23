class Solution:
    def minimizeConcatenation(self, A: List[str], B: List[str]) -> int:
        from collections import deque

        def process(queue):
            res = []
            while queue:
                s = queue.popleft()
                if not res:
                    res.append(s)
                else:
                    if s[0] == res[-1][-1]:
                        res[-1] += s[1:]
                    else:
                        res.append(s)
            return res

        qA = deque(A)
        qB = deque(B)

        a = process(qA)
        b = process(qB)

        i = j = 0
        res = []

        while i < len(a) and j < len(b):
            if a[i][0] <= b[j][0]:
                res.append(a[i])
                i += 1
            else:
                res.append(b[j])
                j += 1

        while i < len(a):
            res.append(a[i])
            i += 1

        while j < len(b):
            res.append(b[j])
            j += 1

        return len("".join(res))