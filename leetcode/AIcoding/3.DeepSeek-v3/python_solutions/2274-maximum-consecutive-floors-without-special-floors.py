class Solution:
    def maxConsecutive(self, bottom: int, top: int, special: List[int]) -> int:
        special.sort()
        max_gap = 0

        # Check the gap between bottom and the first special floor
        max_gap = max(max_gap, special[0] - bottom)

        # Check the gaps between consecutive special floors
        for i in range(1, len(special)):
            max_gap = max(max_gap, special[i] - special[i-1] - 1)

        # Check the gap between the last special floor and top
        max_gap = max(max_gap, top - special[-1])

        return max_gap