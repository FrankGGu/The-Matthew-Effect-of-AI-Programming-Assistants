from collections import deque

class Solution:
    def predictPartyVictory(self, senate: str) -> str:
        n = len(senate)
        q = deque()
        for i in range(n):
            q.append(i)
        while len(q) > 1:
            i = q.popleft()
            if senate[i] == 'R':
                if any(senate[j] == 'D' for j in q):
                    q.append(i)
                else:
                    return "Radiant"
            else:
                if any(senate[j] == 'R' for j in q):
                    q.append(i)
                else:
                    return "Dire"
        return "Radiant" if senate[q[0]] == 'R' else "Dire"