class Solution:
    def numberOfWays(self, n: int, edges: list[list[int]], dist: list[int]) -> int:
        MOD = 10**9 + 7

        # The problem states that for any pair of nodes u and v,
        # the XOR sum of weights on the unique path between u and v
        # must be equal to dist[u] ^ dist[v].

        # Let val[i] be the XOR sum of weights on the path from an arbitrary root (say, node 0) to node i.
        # Then, for any edge (u, v), the weight w_{u,v} = val[u] ^ val[v].
        # The XOR sum of weights on the path between u and v is val[u] ^ val[v].
        # So, the condition becomes val[u] ^ val[v] = dist[u] ^ dist[v] for all u, v.

        # This implies that val[i] ^ dist[i] must be a constant for all i.
        # Let val[i] ^ dist[i] = C.
        # Then, val[i] = C ^ dist[i].

        # Now, let's check the edge weights using this definition of val[i]:
        # w_{u,v} = val[u] ^ val[v] = (C ^ dist[u]) ^ (C ^ dist[v]) = dist[u] ^ dist[v].

        # This means that the edge weights w_{u,v} are uniquely determined by the dist array,
        # and they are independent of the choice of C.
        # The problem requires w_{u,v} to be non-negative, which is always true for XOR results.

        # The "number of ways" refers to the number of possible choices for the constant C.
        # Since dist[i] values are non-negative integers up to 10^9,
        # the relevant bits for C are those that can affect val[i] within this range.
        # If C has bits set higher than the maximum bit position in any dist[i],
        # those higher bits will cancel out when computing w_{u,v} = val[u] ^ val[v].
        # For example, if dist[i] values only use bits 0 to 29, and C has bit 30 set,
        # then val[i] will also have bit 30 set. But val[u]^val[v] will not have bit 30 set.

        # Thus, we only need to consider C values that affect the bits up to the maximum bit
        # present in any dist[i].
        # Let K be the smallest integer such that 2^K is greater than max(dist[i]).
        # If max(dist[i]) = 0, then K=1 (allowing C=0 or C=1).
        # Otherwise, K = max(dist[i]).bit_length().
        # The number of ways to choose C is 2^K.

        max_dist_val = 0
        for d_val in dist:
            if d_val > max_dist_val:
                max_dist_val = d_val

        k = 0
        if max_dist_val == 0:
            # If all dist values are 0, then val[i] must all be equal (e.g., C).
            # The edge weights are all 0.
            # C can be 0 or 1 (or any other value, but we consider up to the smallest K that makes sense).
            # For max_dist_val = 0, bit_length() is 0. We need K=1 to allow C=0 and C=1.
            k = 1
        else:
            # For max_dist_val > 0, bit_length() gives the number of bits required to represent max_dist_val.
            # This is equivalent to the position of the most significant bit + 1.
            # For example, if max_dist_val = 1 (binary 1), bit_length() is 1. K=1. 2^1 ways.
            # If max_dist_val = 3 (binary 11), bit_length() is 2. K=2. 2^2 ways.
            k = max_dist_val.bit_length()

        return pow(2, k, MOD)