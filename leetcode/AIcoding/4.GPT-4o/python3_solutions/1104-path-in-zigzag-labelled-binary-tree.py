class Solution:
    def pathInZigZagTree(self, label: int) -> List[int]:
        path = []
        while label > 0:
            path.append(label)
            label //= 2
        path.reverse()
        for i in range(1, len(path)):
            level = i + 1
            if level % 2 == 0:
                path[i] = (1 << level) - 1 - path[i]
        return path