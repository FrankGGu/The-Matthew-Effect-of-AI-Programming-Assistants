class Solution:
    def maxTotalFruits(self, position: List[int], fruits: List[int], startPos: int) -> int:
        from collections import defaultdict

        pos_to_fruit = defaultdict(int)
        for p, f in zip(position, fruits):
            pos_to_fruit[p] += f

        sorted_positions = sorted(pos_to_fruit.keys())
        n = len(sorted_positions)

        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + pos_to_fruit[sorted_positions[i]]

        res = 0
        left = 0
        for right in range(n):
            while sorted_positions[right] - startPos > k or startPos - sorted_positions[left] > k:
                left += 1
            if sorted_positions[right] - startPos <= k and startPos - sorted_positions[left] <= k:
                res = max(res, prefix[right + 1] - prefix[left])

        return res