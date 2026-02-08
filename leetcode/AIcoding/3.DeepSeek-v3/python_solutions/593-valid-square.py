class Solution:
    def validSquare(self, p1: List[int], p2: List[int], p3: List[int], p4: List[int]) -> bool:
        def distance(a, b):
            return (a[0] - b[0])**2 + (a[1] - b[1])**2

        points = [p1, p2, p3, p4]
        distances = []

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                distances.append(distance(points[i], points[j]))

        distances.sort()

        return distances[0] > 0 and distances[0] == distances[1] == distances[2] == distances[3] and distances[4] == distances[5] and distances[4] == 2 * distances[0]