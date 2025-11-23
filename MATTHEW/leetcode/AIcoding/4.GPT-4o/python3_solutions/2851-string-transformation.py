class Solution:
    def canTransform(self, start: str, end: str) -> bool:
        if start.replace('X', '') != end.replace('X', ''):
            return False

        s, e = 0, 0
        while s < len(start) and e < len(end):
            while s < len(start) and start[s] == 'X':
                s += 1
            while e < len(end) and end[e] == 'X':
                e += 1

            if s < len(start) and e < len(end):
                if start[s] != end[e]:
                    return False
                if start[s] == 'L' and s < e:
                    return False
                if start[s] == 'R' and s > e:
                    return False
                s += 1
                e += 1
            else:
                break

        return True