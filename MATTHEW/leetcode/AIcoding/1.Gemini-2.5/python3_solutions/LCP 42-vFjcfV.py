from typing import List

class Solution:
    def maxRings(self, rings: List[int], pegs: List[int]) -> int:
        rings.sort()
        pegs.sort()

        ring_ptr = 0
        peg_ptr = 0
        successful_fits = 0

        while ring_ptr < len(rings) and peg_ptr < len(pegs):
            if rings[ring_ptr] >= pegs[peg_ptr]:
                successful_fits += 1
                ring_ptr += 1
                peg_ptr += 1
            else:
                ring_ptr += 1

        return successful_fits