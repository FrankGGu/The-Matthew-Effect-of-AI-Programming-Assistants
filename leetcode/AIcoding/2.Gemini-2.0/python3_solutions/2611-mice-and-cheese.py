class Solution:
    def miceAndCheese(self, reward1: list[int], reward2: list[int], k: int) -> int:
        n = len(reward1)
        diff = []
        for i in range(n):
            diff.append((reward1[i] - reward2[i], i))

        diff.sort(reverse=True)

        ans = 0
        for i in range(k):
            ans += reward1[diff[i][1]]

        for i in range(k, n):
            ans += reward2[diff[i][1]]

        return ans