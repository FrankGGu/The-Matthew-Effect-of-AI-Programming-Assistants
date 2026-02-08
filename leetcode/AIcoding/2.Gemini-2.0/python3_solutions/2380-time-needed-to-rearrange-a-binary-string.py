class Solution:
    def secondsToRemoveOccurrences(self, s: str) -> int:
        ans = 0
        while True:
            changed = False
            new_s = ""
            i = 0
            while i < len(s):
                if s[i] == '0':
                    if i + 1 < len(s) and s[i + 1] == '1':
                        new_s += '10'
                        i += 2
                        changed = True
                    else:
                        new_s += '0'
                        i += 1
                else:
                    new_s += '1'
                    i += 1

            if not changed:
                break

            s = new_s
            ans += 1

        return ans