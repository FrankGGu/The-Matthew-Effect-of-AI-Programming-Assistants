class Solution:
    def predictPartyVictory(self, senate: str) -> str:
        radiant, dire = senate.count('R'), senate.count('D')
        queue_r, queue_d = collections.deque(), collections.deque()

        for i, s in enumerate(senate):
            if s == 'R':
                queue_r.append(i)
            else:
                queue_d.append(i)

        n = len(senate)

        while queue_r and queue_d:
            r_index = queue_r.popleft()
            d_index = queue_d.popleft()

            if r_index < d_index:
                queue_r.append(r_index + n)
            else:
                queue_d.append(d_index + n)

        return "Radiant" if queue_r else "Dire"