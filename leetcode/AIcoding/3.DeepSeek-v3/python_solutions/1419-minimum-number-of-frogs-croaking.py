class Solution:
    def minNumberOfFrogs(self, croakOfFrogs: str) -> int:
        count = {'c': 0, 'r': 0, 'o': 0, 'a': 0, 'k': 0}
        frogs = 0
        res = 0

        for ch in croakOfFrogs:
            if ch not in count:
                return -1
            count[ch] += 1

            if ch == 'c':
                frogs += 1
                res = max(res, frogs)
            elif ch == 'k':
                frogs -= 1
            else:
                pass

            if not (count['c'] >= count['r'] >= count['o'] >= count['a'] >= count['k']):
                return -1

        if count['c'] == count['r'] == count['o'] == count['a'] == count['k']:
            return res
        else:
            return -1