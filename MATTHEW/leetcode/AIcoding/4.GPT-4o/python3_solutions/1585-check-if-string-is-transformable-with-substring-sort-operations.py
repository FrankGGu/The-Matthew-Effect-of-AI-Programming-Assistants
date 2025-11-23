class Solution:
    def isTransformable(self, s: str, t: str) -> bool:
        from collections import deque

        if sorted(s) != sorted(t):
            return False

        s_deque = deque(s)
        t_deque = deque(t)

        while t_deque:
            if s_deque[0] == t_deque[0]:
                s_deque.popleft()
                t_deque.popleft()
            else:
                if s_deque[0] > t_deque[0]:
                    return False
                else:
                    while s_deque and s_deque[0] < t_deque[0]:
                        s_deque.popleft()

        return True