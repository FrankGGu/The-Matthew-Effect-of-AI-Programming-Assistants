class Solution:
    def canChange(self, start: str, target: str) -> bool:
        if start.replace('X', '') != target.replace('X', ''):
            return False

        s_idx, t_idx = 0, 0
        while s_idx < len(start) and t_idx < len(target):
            while s_idx < len(start) and start[s_idx] == 'X':
                s_idx += 1
            while t_idx < len(target) and target[t_idx] == 'X':
                t_idx += 1
            if s_idx == len(start) and t_idx == len(target):
                return True
            if s_idx == len(start) or t_idx == len(target):
                return False
            if start[s_idx] != target[t_idx]:
                return False
            if start[s_idx] == 'L' and s_idx < t_idx:
                return False
            if start[s_idx] == 'R' and s_idx > t_idx:
                return False
            s_idx += 1
            t_idx += 1

        return True