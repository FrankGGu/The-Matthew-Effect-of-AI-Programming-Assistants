class Solution:
    def digitGame(self, num: str) -> bool:
        n = len(num)
        if n % 2 == 0:
            return any(int(num[i]) >= 5 for i in range(1, n, 2))
        else:
            return all(int(num[i]) < 5 for i in range(0, n, 2))