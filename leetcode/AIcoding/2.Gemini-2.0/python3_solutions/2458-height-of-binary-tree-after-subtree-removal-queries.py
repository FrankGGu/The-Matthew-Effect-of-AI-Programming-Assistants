from collections import defaultdict

class Solution:
    def treeQueries(self, root, queries):
        depths = defaultdict(list)
        def dfs(node, depth):
            if not node:
                return -1
            left_depth = dfs(node.left, depth + 1)
            right_depth = dfs(node.right, depth + 1)
            depths[depth].append(left_depth)
            depths[depth].append(right_depth)
            return max(left_depth, right_depth) + 1
        dfs(root, 0)

        for depth in depths:
            depths[depth].sort(reverse=True)
            if len(depths[depth]) < 2:
                depths[depth].append(-1)

        result = []
        def find_depth(node, depth, removed_depth):
            if not node:
                return -1
            if depth == removed_depth:
                return depths[depth][1]
            else:
                left_depth = find_depth(node.left, depth + 1, removed_depth)
                right_depth = find_depth(node.right, depth + 1, removed_depth)
                return max(left_depth, right_depth) + 1

        nodes_at_depth = defaultdict(list)
        def populate_nodes(node, depth):
            if not node:
                return
            nodes_at_depth[depth].append(node)
            populate_nodes(node.left, depth + 1)
            populate_nodes(node.right, depth + 1)
        populate_nodes(root, 0)

        for query in queries:
            removed_depth = query

            if len(nodes_at_depth[0]) > 0:

                removed_node = nodes_at_depth[removed_depth][0] if len(nodes_at_depth[removed_depth]) > 0 else None

                max_depth = -1

                if root in nodes_at_depth[0]:

                    if len(nodes_at_depth[removed_depth]) > 0:

                        if len(nodes_at_depth[removed_depth]) == 1 and nodes_at_depth[removed_depth][0] == nodes_at_depth[removed_depth][0]:
                            if removed_depth == 0:
                                max_depth = -1
                            else:
                                max_depth = depths[0][1]
                        else:

                            max_depth = find_depth(root, 0, removed_depth)
                    else:
                        max_depth = find_depth(root, 0, removed_depth)
                else:
                    max_depth = find_depth(root, 0, removed_depth)

                result.append(max_depth)
        return result