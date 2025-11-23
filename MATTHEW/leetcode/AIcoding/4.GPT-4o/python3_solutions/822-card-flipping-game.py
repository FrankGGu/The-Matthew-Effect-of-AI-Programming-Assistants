class Solution:
    def flipgame(self, fronts: List[int], backs: List[int]) -> int:
        bad_numbers = set()
        for front, back in zip(fronts, backs):
            if front == back:
                bad_numbers.add(front)
        result = float('inf')
        for front in fronts:
            if front not in bad_numbers:
                result = min(result, front)
        for back in backs:
            if back not in bad_numbers:
                result = min(result, back)
        return result if result != float('inf') else 0