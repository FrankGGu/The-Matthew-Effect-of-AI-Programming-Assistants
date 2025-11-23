import math

class Solution:
    def minimumCost(self, source: str, target: str, original: list[str], changed: list[str], cost: list[int]) -> int:
        num_chars = 26
        # Initialize min_costs matrix with infinity
        # min_costs[i][j] will store the minimum cost to convert character i to character j
        # where i and j are 0-indexed (0 for 'a', 1 for 'b', ..., 25 for 'z')
        min_costs = [[math.inf] * num_chars for _ in range(num_chars)]

        # The cost to convert a character to itself is 0
        for i in range(num_chars):
            min_costs[i][i] = 0

        # Populate min_costs with direct conversion costs
        # If multiple conversions exist for the same pair, take the minimum cost
        for k in range(len(original)):
            src_char_idx = ord(original[k]) - ord('a')
            tgt_char_idx = ord(changed[k]) - ord('a')
            min_costs[src_char_idx][tgt_char_idx] = min(min_costs[src_char_idx][tgt_char_idx], cost[k])

        # Floyd-Warshall algorithm to find all-pairs shortest paths
        # k is the intermediate character (node)
        for k in range(num_chars):
            # i is the source character (node)
            for i in range(num_chars):
                # j is the destination character (node)
                for j in range(num_chars):
                    # If there's a path from i to k and from k to j,
                    # consider if i -> k -> j is cheaper than the current i -> j path
                    if min_costs[i][k] != math.inf and min_costs[k][j] != math.inf:
                        min_costs[i][j] = min(min_costs[i][j], min_costs[i][k] + min_costs[k][j])

        total_min_cost = 0
        # Calculate the total minimum cost to transform source into target
        for i in range(len(source)):
            # If characters at the current position are different, a conversion is needed
            if source[i] != target[i]:
                src_char_idx = ord(source[i]) - ord('a')
                tgt_char_idx = ord(target[i]) - ord('a')

                conversion_cost = min_costs[src_char_idx][tgt_char_idx]

                # If the cost is still infinity, it means no path exists to convert
                # source[i] to target[i], so the transformation is impossible
                if conversion_cost == math.inf:
                    return -1

                total_min_cost += conversion_cost

        return total_min_cost