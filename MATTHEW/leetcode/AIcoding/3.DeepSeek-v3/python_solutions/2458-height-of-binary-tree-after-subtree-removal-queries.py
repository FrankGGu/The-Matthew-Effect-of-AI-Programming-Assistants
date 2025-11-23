class Solution:
    def treeQueries(self, root: Optional[TreeNode], queries: List[int]) -> List[int]:
        depth = {}
        height = {}
        def dfs(node, d):
            if not node:
                return -1
            depth[node.val] = d
            h = max(dfs(node.left, d + 1), dfs(node.right, d + 1)) + 1
            height[node.val] = h
            return h
        dfs(root, 0)

        from collections import defaultdict
        cousins = defaultdict(list)
        for val in depth:
            d = depth[val]
            cousins[d].append((-height[val], val))
            cousins[d].sort()
            if len(cousins[d]) > 2:
                cousins[d].pop()

        res = []
        for q in queries:
            d = depth[q]
            if len(cousins[d]) == 1:
                res.append(d - 1)
            else:
                if cousins[d][0][1] == q:
                    tmp = -cousins[d][1][0]
                else:
                    tmp = -cousins[d][0][0]
                res.append(d + tmp)
        return res