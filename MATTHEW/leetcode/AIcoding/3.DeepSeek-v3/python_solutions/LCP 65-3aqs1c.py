class Solution:
    def comfortableHumidity(self, current: int, target: int, humidifiers: List[int], dehumidifiers: List[int]) -> int:
        from collections import deque

        visited = set()
        queue = deque()
        queue.append((current, 0))
        visited.add(current)

        while queue:
            humidity, steps = queue.popleft()
            if humidity == target:
                return steps

            for h in humidifiers:
                new_humidity = humidity + h
                if new_humidity not in visited and new_humidity <= 100:
                    visited.add(new_humidity)
                    queue.append((new_humidity, steps + 1))

            for d in dehumidifiers:
                new_humidity = humidity - d
                if new_humidity not in visited and new_humidity >= 0:
                    visited.add(new_humidity)
                    queue.append((new_humidity, steps + 1))

        return -1