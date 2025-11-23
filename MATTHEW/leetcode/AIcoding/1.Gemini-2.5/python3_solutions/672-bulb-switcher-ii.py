class Solution:
    def flipLights(self, n: int, m: int) -> int:
        if m == 0:
            return 1

        if n == 1:
            return 2
        elif n == 2:
            if m == 1:
                return 4
            else: # m >= 2
                return 4
        else: # n >= 3
            if m == 1:
                return 5
            else: # m >= 2
                return 8