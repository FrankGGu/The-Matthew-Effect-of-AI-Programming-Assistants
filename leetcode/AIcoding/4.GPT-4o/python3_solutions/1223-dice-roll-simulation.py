from random import randint

class Solution:
    def simulateDiceRolls(self, n: int) -> List[int]:
        return [randint(1, 6) for _ in range(n)]