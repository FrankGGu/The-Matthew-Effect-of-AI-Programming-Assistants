class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeQueries(self, root: TreeNode, queries: List[int]) -> List[int]:
        def dfs(node):
            if not node:
                return 0, []
            left_height, left_nodes = dfs(node.left)
            right_height, right_nodes = dfs(node.right)
            height = 1 + max(left_height, right_height)
            nodes = left_nodes + right_nodes + [height]
            return height, nodes

        def get_height(node, height_map):
            if not node:
                return 0
            left_height = get_height(node.left, height_map)
            right_height = get_height(node.right, height_map)
            height = max(left_height, right_height) + 1
            height_map[node.val] = height
            return height

        height_map = {}
        get_height(root, height_map)
        heights = sorted(height_map.values(), reverse=True)
        result = []

        for query in queries:
            h = height_map[query]
            second_max_height = heights[1] if len(heights) > 1 and heights[0] == h else heights[0]
            result.append(max(h, second_max_height))

        return result