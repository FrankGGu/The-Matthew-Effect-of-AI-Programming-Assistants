class Solution:
    def memLeak(self, memory1: int, memory2: int) -> List[int]:
        time = 1
        while True:
            if memory1 >= memory2:
                if memory1 < time:
                    break
                memory1 -= time
            else:
                if memory2 < time:
                    break
                memory2 -= time
            time += 1
        return [time, memory1, memory2]