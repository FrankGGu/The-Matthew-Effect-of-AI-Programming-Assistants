class Solution:
    def shortestImpossibleSequence(self, rolls: list[int], k: int) -> int:

        current_target = 1

        for roll in rolls:
            if roll == current_target:
                current_target += 1

        return current_target