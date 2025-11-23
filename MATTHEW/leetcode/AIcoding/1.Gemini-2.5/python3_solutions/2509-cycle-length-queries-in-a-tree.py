class Solution:
    def cycleLengthQueries(self, n: int, queries: list[list[int]]) -> list[int]:

        def get_depth(node: int) -> int:
            # The depth of node i is floor(log2(i)).
            # This is equivalent to node.bit_length() - 1.
            # Node 1 is at depth 0.
            return node.bit_length() - 1

        def get_lca(u: int, v: int) -> int:
            depth_u = get_depth(u)
            depth_v = get_depth(v)

            # Bring u and v to the same depth
            while depth_u > depth_v:
                u //= 2
                depth_u -= 1
            while depth_v > depth_u:
                v //= 2
                depth_v -= 1

            # Move both nodes up simultaneously until they meet
            while u != v:
                u //= 2
                v //= 2
            return u

        results = []
        for u, v in queries:
            depth_u = get_depth(u)
            depth_v = get_depth(v)

            lca_node = get_lca(u, v)
            depth_lca = get_depth(lca_node)

            # The length of the cycle formed by adding an edge (u, v)
            # is dist(u, LCA(u,v)) + dist(v, LCA(u,v)) + 1.
            # This is equivalent to (depth_u - depth_lca) + (depth_v - depth_lca) + 1.
            # Which simplifies to depth_u + depth_v - 2 * depth_lca + 1.
            cycle_length = depth_u + depth_v - 2 * depth_lca + 1
            results.append(cycle_length)

        return results