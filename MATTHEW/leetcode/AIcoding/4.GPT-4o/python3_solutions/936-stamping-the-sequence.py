class Solution:
    def movesToStamp(self, stamp: str, target: str) -> List[int]:
        m, n = len(stamp), len(target)
        stamp_set = set()
        target_set = set(target)
        visited = [False] * n
        result = []

        def can_stamp(i):
            for j in range(m):
                if i + j >= n:
                    return False
                if target[i + j] != '?' and target[i + j] != stamp[j]:
                    return False
            return True

        def do_stamp(i):
            for j in range(m):
                target[i + j] = '?'

        while target_set:
            stamped = False
            for i in range(n - m + 1):
                if not visited[i] and can_stamp(i):
                    do_stamp(i)
                    visited[i] = True
                    result.append(i)
                    stamped = True
                    target_set -= set(target[i:i + m])

            if not stamped:
                return []

        return result[::-1]