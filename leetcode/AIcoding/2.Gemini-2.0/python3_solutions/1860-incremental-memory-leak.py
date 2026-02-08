class Solution:
    def memLeak(self, memory1: int, memory2: int) -> list[int]:
        i = 1
        while memory1 >= i or memory2 >= i:
            if memory1 >= memory2:
                if memory1 >= i:
                    memory1 -= i
                else:
                    break
            else:
                if memory2 >= i:
                    memory2 -= i
                else:
                    break
            i += 1
        return [i, memory1, memory2]