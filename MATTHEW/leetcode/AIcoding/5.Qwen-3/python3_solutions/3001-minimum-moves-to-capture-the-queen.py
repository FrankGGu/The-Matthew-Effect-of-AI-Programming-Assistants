class Solution:
    def minMovesToCaptureTheQueen(self, a: List[int], b: List[int]) -> int:
        def is_blocked(x1, y1, x2, y2, x3, y3):
            if x1 == x2:
                for y in range(min(y1, y2) + 1, max(y1, y2)):
                    if x3 == x1 and y3 == y:
                        return True
            elif y1 == y2:
                for x in range(min(x1, x2) + 1, max(x1, x2)):
                    if y3 == y1 and x3 == x:
                        return True
            return False

        if a[0] == b[0] or a[1] == b[1]:
            if not is_blocked(a[0], a[1], b[0], b[1], a[0], a[1]):
                return 1
            else:
                return 2
        else:
            return 2