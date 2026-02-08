class Solution:
    def pathInZigZagTree(self, label: int) -> List[int]:
        res = []
        level = 0
        while (1 << level) <= label:
            level += 1

        while label >= 1:
            res.append(label)
            max_level = (1 << level) - 1
            min_level = 1 << (level - 1)
            label = (max_level + min_level - label) // 2
            level -= 1

        return res[::-1]