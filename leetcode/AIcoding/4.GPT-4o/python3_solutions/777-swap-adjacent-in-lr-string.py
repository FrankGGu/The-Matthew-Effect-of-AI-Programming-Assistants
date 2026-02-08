class Solution:
    def canTransform(self, start: str, end: str) -> bool:
        if start.replace('X', '') != end.replace('X', ''):
            return False

        start_pos = [i for i in range(len(start)) if start[i] != 'X']
        end_pos = [i for i in range(len(end)) if end[i] != 'X']

        if len(start_pos) != len(end_pos):
            return False

        for s, e in zip(start_pos, end_pos):
            if (s < e and start[s] == 'L') or (s > e and start[s] == 'R'):
                return False

        return True