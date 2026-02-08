class Solution:
    def maxConsecutive(self, bottom: int, top: int, special: List[int]) -> int:
        special.sort()
        max_consecutive = 0

        # Check the space before the first special floor
        if special:
            max_consecutive = max(max_consecutive, special[0] - bottom)

        # Check the spaces between special floors
        for i in range(1, len(special)):
            max_consecutive = max(max_consecutive, special[i] - special[i - 1] - 1)

        # Check the space after the last special floor
        if special:
            max_consecutive = max(max_consecutive, top - special[-1])
        else:
            max_consecutive = top - bottom + 1

        return max_consecutive