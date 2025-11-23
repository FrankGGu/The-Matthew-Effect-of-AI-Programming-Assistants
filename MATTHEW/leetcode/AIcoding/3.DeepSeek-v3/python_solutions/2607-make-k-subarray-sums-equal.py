class Solution:
    def makeSubKSumEqual(self, arr: List[int], k: int) -> int:
        n = len(arr)
        visited = [False] * n
        res = 0
        for i in range(n):
            if not visited[i]:
                group = []
                j = i
                while not visited[j]:
                    visited[j] = True
                    group.append(arr[j])
                    j = (j + k) % n
                group.sort()
                median = group[len(group) // 2]
                res += sum(abs(num - median) for num in group)
        return res