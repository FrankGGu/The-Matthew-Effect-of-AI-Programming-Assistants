import java.util.*;

class Solution {
    public boolean sequenceReconstruction(int[] org, List<List<Integer>> seqs) {
        int n = org.length;

        // Step 1: Build graph (adjacency list and in-degree array)
        // Nodes are from 1 to n, as org is a permutation of [1, ..., n].
        int[] inDegree = new int[n + 1];
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        // Keep track of unique numbers present in seqs.
        // This helps verify if all numbers from 1 to n are covered by seqs.
        Set<Integer> uniqueNumsInSeqs = new HashSet<>();

        for (List<Integer> seq : seqs) {
            if (seq.isEmpty()) {
                continue; // Skip empty sequences
            }

            // Check if all numbers in the current sequence are within the valid range [1, n].
            // If any number is outside this range, it means `org` (which contains numbers 1 to n)
            // cannot be the unique reconstruction from `seqs` because `seqs` implies other numbers exist.
            for (int num : seq) {
                if (num < 1 || num > n) {
                    return false; 
                }
                uniqueNumsInSeqs.add(num);
            }

            // Add edges and update in-degrees based on adjacent elements in the sequence.
            for (int i = 0; i < seq.size() - 1; i++) {
                int u = seq.get(i);
                int v = seq.get(i + 1);
                adj.get(u).add(v);
                inDegree[v]++;
            }
        }

        // If the number of unique elements found in `seqs` is less than `n`,
        // it means some numbers from `org` are missing in `seqs`.
        // Therefore, `org` cannot be fully reconstructed.
        if (uniqueNumsInSeqs.size() < n) {
            return false;
        }

        // Step 2: Initialize queue with nodes having in-degree 0
        Queue<Integer> q = new LinkedList<>();
        for (int i = 1; i <= n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        // Step 3: Perform topological sort (Kahn's algorithm)
        List<Integer> reconstructedSequence = new ArrayList<>();
        while (!q.isEmpty()) {
            // If at any point there is more than one node with in-degree 0,
            // it means there are multiple choices for the next element in the sequence.
            // Thus, the topological sort is not unique.
            if (q.size() > 1) {
                return false;
            }

            int u = q.poll();
            reconstructedSequence.add(u);

            // For each neighbor 'v' of 'u', decrement its in-degree.
            // If 'v's in-degree becomes 0, add it to the queue.
            for (int v : adj.get(u)) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // Step 4: Check if the reconstructed sequence is valid and matches `org`
        // The length of the reconstructed sequence must be equal to `n`.
        // If not, it implies a cycle existed in the graph or some nodes from 1 to n were unreachable
        // (e.g., if `uniqueNumsInSeqs.size() < n` condition was not triggered for some reason,
        // or if `seqs` implies a cycle).
        if (reconstructedSequence.size() != n) {
            return false;
        }

        // Finally, compare the reconstructed sequence with the original `org` sequence.
        // They must be identical for `org` to be the unique reconstruction.
        for (int i = 0; i < n; i++) {
            if (reconstructedSequence.get(i) != org[i]) {
                return false;
            }
        }

        return true;
    }
}