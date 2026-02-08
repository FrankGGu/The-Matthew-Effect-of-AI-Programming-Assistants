class Solution:
    def minOperations(self, s1: str, s2: str, x: int) -> int:
        diff_indices = []
        for i in range(len(s1)):
            if s1[i] != s2[i]:
                diff_indices.append(i)

        m = len(diff_indices)

        if m == 0:
            return 0

        # Operation 1: Choose two indices i and j such that s1[i] != s2[i] and s1[j] != s2[j].
        # Flip s1[i] and s1[j]. Cost is x.
        # "Flip s1[i] and s1[j]" means s1[i] = 1 - s1[i] and s1[j] = 1 - s1[j].
        # Since s1[i] != s2[i], after flipping, s1[i] will become s2[i]. Same for s1[j].
        # Thus, Operation 1 resolves two differing positions for a cost of x.

        # Operation 2: Choose one index i such that s1[i] != s2[i]. Flip s1[i]. Cost is 1.
        # Operation 2 resolves one differing position for a cost of 1.

        # We have 'm' positions that need to be resolved.
        # To resolve a pair of differing positions, we have two options:
        # 1. Use Operation 1: Cost x.
        # 2. Use Operation 2 twice (once for each position): Cost 1 + 1 = 2.
        # So, the minimum cost to resolve any two differing positions is min(x, 2).

        # Let cost_per_pair = min(x, 2).

        # Case 1: 'm' is even.
        # We can form m / 2 pairs of differing positions.
        # The total cost will be (m / 2) * cost_per_pair.

        # Case 2: 'm' is odd.
        # We must resolve at least one position using Operation 2 (cost 1).
        # The remaining (m - 1) positions can form (m - 1) / 2 pairs.
        # The total cost will be 1 + ((m - 1) / 2) * cost_per_pair.

        cost_per_pair = min(x, 2)

        if m % 2 == 0:
            return (m // 2) * cost_per_pair
        else:
            return (m // 2) * cost_per_pair + 1