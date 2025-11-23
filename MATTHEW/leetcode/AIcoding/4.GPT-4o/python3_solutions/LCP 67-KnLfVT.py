class Solution:
    def decorateTree(self, tree: List[int]) -> List[int]:
        n = len(tree)
        if n == 0:
            return []

        max_height = 0
        for h in tree:
            max_height = max(max_height, h)

        result = [0] * n
        for i in range(n):
            result[i] = max_height - tree[i]

        return result