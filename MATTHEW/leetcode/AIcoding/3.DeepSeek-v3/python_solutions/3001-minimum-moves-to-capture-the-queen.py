class Solution:
    def minMovesToCaptureTheQueen(self, a: int, b: int, c: int, d: int, e: int, f: int) -> int:
        # Check if rook can capture queen in one move
        if a == e and (c != e or (d < min(b, f) or d > max(b, f))):
            return 1
        if b == f and (d != f or (c < min(a, e) or c > max(a, e))):
            return 1

        # Check if bishop can capture queen in one move
        if (c + d) == (e + f) and (a + b) != (e + f) or (c - d) == (e - f) and (a - b) != (e - f):
            return 1
        if (c + d) == (e + f) or (c - d) == (e - f):
            # Check if any piece is blocking the bishop's path
            # For diagonal c + d = e + f
            if (c + d) == (e + f):
                start_x = min(c, e)
                start_y = max(c, e) - (e - f) if c < e else (c - d) + start_x
                end_x = max(c, e)
                while start_x < end_x:
                    start_x += 1
                    start_y -= 1
                    if start_x == a and start_y == b:
                        break
                else:
                    return 1
            # For diagonal c - d = e - f
            if (c - d) == (e - f):
                start_x = min(c, e)
                start_y = min(d, f)
                end_x = max(c, e)
                while start_x < end_x:
                    start_x += 1
                    start_y += 1
                    if start_x == a and start_y == b:
                        break
                else:
                    return 1

        # Check if rook can capture queen in two moves (via bishop's position)
        if (a + b) == (e + f) or (a - b) == (e - f):
            return 2
        if (c == e or d == f) and (a == c or b == d):
            return 2

        # Otherwise, maximum two moves
        return 2