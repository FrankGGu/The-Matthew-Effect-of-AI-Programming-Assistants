class Solution:
    def relocateMarbles(self, nums: List[int], moveFrom: List[int], moveTo: List[int]) -> List[int]:
        marble_set = set(nums)
        for f, t in zip(moveFrom, moveTo):
            if f in marble_set:
                marble_set.remove(f)
                marble_set.add(t)
        return sorted(marble_set)