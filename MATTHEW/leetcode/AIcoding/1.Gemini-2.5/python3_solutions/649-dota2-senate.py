import collections

class Solution:
    def predictPartyVictory(self, senate: str) -> str:
        n = len(senate)
        radiant_q = collections.deque()
        dire_q = collections.deque()

        for i, char in enumerate(senate):
            if char == 'R':
                radiant_q.append(i)
            else:
                dire_q.append(i)

        while radiant_q and dire_q:
            r_idx = radiant_q.popleft()
            d_idx = dire_q.popleft()

            if r_idx < d_idx:
                radiant_q.append(r_idx + n)
            else:
                dire_q.append(d_idx + n)

        if radiant_q:
            return "Radiant"
        else:
            return "Dire"