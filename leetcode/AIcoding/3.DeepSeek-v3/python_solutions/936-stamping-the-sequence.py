class Solution:
    def movesToStamp(self, stamp: str, target: str) -> List[int]:
        n, m = len(stamp), len(target)
        stamp = list(stamp)
        target = list(target)
        res = []
        changed = True

        def check(i):
            changed = False
            for j in range(n):
                if target[i + j] == '?':
                    continue
                if target[i + j] != stamp[j]:
                    return False
            for j in range(n):
                if target[i + j] != '?':
                    target[i + j] = '?'
                    changed = True
            return changed

        while changed:
            changed = False
            for i in range(m - n + 1):
                if check(i):
                    changed = True
                    res.append(i)

        return res[::-1] if all(c == '?' for c in target) else []