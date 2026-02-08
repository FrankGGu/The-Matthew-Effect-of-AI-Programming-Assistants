class Solution:
    def canReach(self, sx: int, sy: int, tx: int, ty: int) -> bool:
        while tx >= sx and ty >= sy:
            if tx == sx and ty == sy:
                return True
            if tx > ty:
                tx -= (tx - sx) // (tx // ty)
            else:
                ty -= (ty - sy) // (ty // tx)
        return False