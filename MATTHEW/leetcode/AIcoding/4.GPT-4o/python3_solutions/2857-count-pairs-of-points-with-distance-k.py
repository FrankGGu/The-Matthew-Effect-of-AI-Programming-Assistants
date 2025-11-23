class Solution:
    def countPairs(self, points: List[List[int]], k: int) -> int:
        count = 0
        point_set = set(map(tuple, points))

        for x, y in points:
            for dx in range(-k, k + 1):
                dy = int((k**2 - dx**2) ** 0.5)
                for sign in [-1, 1]:
                    if (x + dx, y + sign * dy) in point_set:
                        count += 1
                    if dy != 0 and (x + dx, y - sign * dy) in point_set:
                        count += 1

        return count // 2