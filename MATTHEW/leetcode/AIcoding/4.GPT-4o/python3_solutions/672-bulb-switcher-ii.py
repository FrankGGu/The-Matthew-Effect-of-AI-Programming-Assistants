class Solution:
    def flipLights(self, n: int, presses: int) -> int:
        if n == 0:
            return 0
        if presses == 0:
            return 1

        states = set()
        for i in range(1 << 4):
            if bin(i).count('1') <= presses:
                if n == 1:
                    states.add(1)
                elif n == 2:
                    if (i & 1) or (i & 2):
                        states.add(1)
                    if (i & 1) or (i & 4):
                        states.add(2)
                    if (i & 2) or (i & 4):
                        states.add(3)
                else:
                    if (i & 1) or (i & 2) or (i & 4):
                        states.add(1)
                    if (i & 1) or (i & 4):
                        states.add(2)
                    if (i & 2) or (i & 4):
                        states.add(3)
                    if (i & 1) or (i & 2):
                        states.add(4)
                    if (i & 1) and (i & 2):
                        states.add(5)
                    if (i & 1) and (i & 4):
                        states.add(6)
                    if (i & 2) and (i & 4):
                        states.add(7)
                    if (i & 1) and (i & 2) and (i & 4):
                        states.add(0)

        return len(states)