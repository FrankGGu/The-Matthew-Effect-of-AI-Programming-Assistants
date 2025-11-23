class Solution:
    def relocateMarbles(self, marbles: List[int], moveFrom: List[int], moveTo: List[int]) -> List[int]:
        marble_set = set(marbles)
        for from_pos, to_pos in zip(moveFrom, moveTo):
            if from_pos in marble_set:
                marble_set.remove(from_pos)
                marble_set.add(to_pos)
        return sorted(marble_set)