class Solution:
    def reachingPoints(self, sx: int, sy: int, tx: int, ty: int) -> bool:
        while tx >= sx and ty >= sy:
            if tx == sx and ty == sy:
                return True

            if tx == ty:
                break # If tx == ty and we haven't reached (sx, sy), it's impossible to proceed without going below sx or sy.

            if tx > ty:
                if ty == sy: # If ty is already at sy, we can only reach sx if (tx - sx) is a multiple of ty.
                    return (tx - sx) % ty == 0
                tx %= ty
            else: # ty > tx
                if tx == sx: # If tx is already at sx, we can only reach sy if (ty - sy) is a multiple of tx.
                    return (ty - sy) % tx == 0
                ty %= tx

        return False