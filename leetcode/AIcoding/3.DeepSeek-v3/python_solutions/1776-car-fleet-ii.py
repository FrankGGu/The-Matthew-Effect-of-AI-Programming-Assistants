class Solution:
    def getCollisionTimes(self, cars: List[List[int]]) -> List[float]:
        stack = []
        n = len(cars)
        res = [-1.0] * n

        for i in range(n-1, -1, -1):
            pos, speed = cars[i]
            while stack:
                j = stack[-1]
                prev_pos, prev_speed = cars[j]
                if speed <= prev_speed:
                    stack.pop()
                else:
                    collision_time = (prev_pos - pos) / (speed - prev_speed)
                    if collision_time <= res[j] or res[j] == -1:
                        res[i] = collision_time
                        break
                    else:
                        stack.pop()
            stack.append(i)
        return res