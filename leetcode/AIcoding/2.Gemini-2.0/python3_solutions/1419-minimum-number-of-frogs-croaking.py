class Solution:
    def minNumberOfFrogs(self, croakOfFrogs: str) -> int:
        count = {'c': 0, 'r': 0, 'o': 0, 'a': 0, 'k': 0}
        frogs = 0
        max_frogs = 0
        for char in croakOfFrogs:
            if char == 'c':
                count['c'] += 1
                frogs += 1
                max_frogs = max(max_frogs, frogs)
            elif char == 'r':
                if count['c'] == 0:
                    return -1
                count['c'] -= 1
                count['r'] += 1
            elif char == 'o':
                if count['r'] == 0:
                    return -1
                count['r'] -= 1
                count['o'] += 1
            elif char == 'a':
                if count['o'] == 0:
                    return -1
                count['o'] -= 1
                count['a'] += 1
            elif char == 'k':
                if count['a'] == 0:
                    return -1
                count['a'] -= 1
                count['k'] += 1
                frogs -= 1
            else:
                return -1
        if count['c'] != 0 or count['r'] != 0 or count['o'] != 0 or count['a'] != 0:
            return -1
        return max_frogs