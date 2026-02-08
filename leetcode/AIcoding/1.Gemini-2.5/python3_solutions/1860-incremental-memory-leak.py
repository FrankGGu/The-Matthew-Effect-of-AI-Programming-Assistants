class Solution:
    def memLeak(self, memory1: int, memory2: int) -> list[int]:
        time = 1
        while True:
            if memory1 >= memory2:
                if memory1 < time:
                    return [time, memory1, memory2]
                memory1 -= time
            else:
                if memory2 < time:
                    return [time, memory1, memory2]
                memory2 -= time
            time += 1