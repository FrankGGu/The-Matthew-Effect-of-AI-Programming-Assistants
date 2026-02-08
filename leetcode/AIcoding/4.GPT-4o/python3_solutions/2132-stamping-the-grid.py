class Solution:
    def movesToStamp(self, stamp: str, target: str) -> List[int]:
        n, m = len(target), len(stamp)
        visited = [False] * n
        stampable = [False] * n
        res = []

        def can_stamp(i):
            match = False
            for j in range(m):
                if target[i + j] == '*':
                    continue
                if target[i + j] != stamp[j]:
                    return False
                match = True
            return match

        def do_stamp(i):
            for j in range(m):
                visited[i + j] = True
                stampable[i + j] = True

        count = 0
        while True:
            made_stamp = False
            for i in range(n - m + 1):
                if not visited[i] and can_stamp(i):
                    do_stamp(i)
                    res.append(i)
                    made_stamp = True
                    count += m
            if not made_stamp:
                break

        if count == n:
            return res[::-1]
        return []