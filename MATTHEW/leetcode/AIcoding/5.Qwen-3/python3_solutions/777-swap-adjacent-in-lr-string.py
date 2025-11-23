class Solution:
    def canTransform(self, start: str, end: str) -> bool:
        if len(start) != len(end):
            return False
        i = j = 0
        while i < len(start) and j < len(end):
            if start[i] == end[j]:
                i += 1
                j += 1
            else:
                if start[i] == 'L':
                    return False
                elif end[j] == 'L':
                    return False
                elif start[i] == 'R':
                    if j > 0 and end[j-1] == 'R':
                        j += 1
                    else:
                        return False
                elif end[j] == 'R':
                    if i > 0 and start[i-1] == 'R':
                        i += 1
                    else:
                        return False
                else:
                    return False
        return i == len(start) and j == len(end)