from collections import deque

class Solution:
    def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
        if targetCapacity > jug1Capacity + jug2Capacity:
            return False
        if targetCapacity == 0:
            return True
        if jug1Capacity == 0 and jug2Capacity == 0:
            return False

        q = deque([(0, 0)])
        visited = set()
        visited.add((0, 0))

        while q:
            jug1, jug2 = q.popleft()

            if jug1 + jug2 == targetCapacity:
                return True

            # Fill jug1
            if (jug1Capacity, jug2) not in visited:
                q.append((jug1Capacity, jug2))
                visited.add((jug1Capacity, jug2))

            # Fill jug2
            if (jug1, jug2Capacity) not in visited:
                q.append((jug1, jug2Capacity))
                visited.add((jug1, jug2Capacity))

            # Empty jug1
            if (0, jug2) not in visited:
                q.append((0, jug2))
                visited.add((0, jug2))

            # Empty jug2
            if (jug1, 0) not in visited:
                q.append((jug1, 0))
                visited.add((jug1, 0))

            # Pour jug1 into jug2
            pour_amount = min(jug1, jug2Capacity - jug2)
            if (jug1 - pour_amount, jug2 + pour_amount) not in visited:
                q.append((jug1 - pour_amount, jug2 + pour_amount))
                visited.add((jug1 - pour_amount, jug2 + pour_amount))

            # Pour jug2 into jug1
            pour_amount = min(jug2, jug1Capacity - jug1)
            if (jug1 + pour_amount, jug2 - pour_amount) not in visited:
                q.append((jug1 + pour_amount, jug2 - pour_amount))
                visited.add((jug1 + pour_amount, jug2 - pour_amount))

        return False