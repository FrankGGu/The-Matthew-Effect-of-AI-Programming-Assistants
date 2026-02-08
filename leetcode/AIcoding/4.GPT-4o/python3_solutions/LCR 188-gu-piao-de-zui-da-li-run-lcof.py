def minCostToMoveChips(chips):
    odd = sum(1 for chip in chips if chip % 2 == 1)
    even = len(chips) - odd
    return min(odd, even)