class Solution:
    def distributeMoney(self, money: int, children: int) -> int:
        if money < children:
            return 0

        # Special case: If there's only one child and they would receive exactly $4,
        # it's impossible to satisfy the rules. Return 0.
        # This check is crucial because if 'ans' becomes 0, and this condition is met,
        # 'ans - 1' would result in -1, which is invalid.
        if money == 4 and children == 1:
            return 0

        # Calculate the maximum possible number of children who can receive $8.
        # This is limited by the total money available (money // 8)
        # and the total number of children.
        ans = money // 8
        ans = min(ans, children)

        # Calculate the number of children remaining who still need money,
        # and the amount of money left to distribute among them.
        rem_c = children - ans
        rem_m = money - ans * 8

        # If all children have already received $8 (i.e., no remaining children),
        # then 'ans' is the maximum number of children who got $8.
        if rem_c == 0:
            return ans

        # If there are remaining children, we need to check if the current 'ans'
        # allows for a valid distribution for these remaining children.
        # There are two problematic scenarios that would require reducing 'ans':
        # 1. Not enough money to give at least $1 to each of the remaining children.
        #    (e.g., $2 for 3 children). This means 'rem_m < rem_c'.
        # 2. Exactly $4 is left for exactly one remaining child.
        #    This means 'rem_m == 4' and 'rem_c == 1'.
        #    (The initial check `money == 4 and children == 1` handles the case where `ans` is 0 and this happens).
        #    If 'ans' is greater than 0, this condition means one of the $8 children
        #    must give up their $8 to allow for a valid distribution for the remaining group.
        if rem_m < rem_c or (rem_m == 4 and rem_c == 1):
            return ans - 1

        # If none of the problematic scenarios occur, the current 'ans' is valid.
        # We can distribute 'rem_m' to 'rem_c' children such that each gets at least $1 and not $4.
        # For example, give $1 to (rem_c - 1) children, and the rest (rem_m - (rem_c - 1)) to the last child.
        # Since rem_m >= rem_c, (rem_m - rem_c + 1) will be >= 1.
        # Also, since it's not the (rem_m == 4 and rem_c == 1) case, this final amount will not be $4.
        return ans