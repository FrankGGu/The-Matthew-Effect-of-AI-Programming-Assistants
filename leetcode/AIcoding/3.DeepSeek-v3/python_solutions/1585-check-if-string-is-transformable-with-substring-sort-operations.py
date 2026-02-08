class Solution:
    def isTransformable(self, s: str, t: str) -> bool:
        from collections import defaultdict, deque

        if len(s) != len(t):
            return False

        pos = defaultdict(deque)
        for i, ch in enumerate(s):
            pos[int(ch)].append(i)

        for ch in t:
            d = int(ch)
            if not pos[d]:
                return False
            for smaller in range(d):
                if pos[smaller] and pos[smaller][0] < pos[d][0]:
                    return False
            pos[d].popleft()

        return True