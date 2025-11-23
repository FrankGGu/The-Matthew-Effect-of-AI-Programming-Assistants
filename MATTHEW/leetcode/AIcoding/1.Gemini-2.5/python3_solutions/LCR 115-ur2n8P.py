import collections

class Solution:
    def sequenceReconstruction(self, org: list[int], seqs: list[list[int]]) -> bool:
        n = len(org)

        if n == 0:
            return all(len(s) == 0 for s in seqs)

        graph = collections.defaultdict(list)
        in_degree = collections.defaultdict(int)

        # Use a set to track all unique numbers present in `seqs`
        present_in_seqs = set()

        # Build the graph and calculate in-degrees
        for seq in seqs:
            for x in seq:
                # All numbers in `seqs` must be within the range [1, n]
                # if they are to reconstruct `org`.
                if not (1 <= x <= n):
                    return False
                present_in_seqs.add(x)

            for i in range(len(seq) - 1):
                u, v = seq[i], seq[i+1]
                # Add edge only if it's not a duplicate
                if v not in graph[u]:
                    graph[u].append(v)
                    in_degree[v] += 1

        # Check if all numbers from 1 to n are present in `seqs`
        # and if `seqs` contains any numbers not in `org` (which would be outside [1,n], handled above).
        # This also handles cases where `org` has numbers not present in `seqs`.
        if len(present_in_seqs) != n:
            return False

        # Initialize queue for topological sort with nodes having in-degree 0
        q = collections.deque()
        for i in range(1, n + 1):
            if in_degree[i] == 0: # defaultdict returns 0 for non-existent keys
                q.append(i)

        reconstructed_seq = []

        # Perform topological sort
        while q:
            # If at any point there's more than one node with an in-degree of 0,
            # it means the reconstruction is not unique.
            if len(q) > 1:
                return False

            u = q.popleft()
            reconstructed_seq.append(u)

            for v in graph[u]:
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        # The reconstructed sequence must be identical to `org`
        return reconstructed_seq == org