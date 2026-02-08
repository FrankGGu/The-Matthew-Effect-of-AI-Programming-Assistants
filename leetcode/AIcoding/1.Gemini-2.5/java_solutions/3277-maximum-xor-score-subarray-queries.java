import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

class Solution {
    private static final int MAX_BITS = 30; // Max value 10^9 < 2^30

    static class TrieNode {
        TrieNode[] children = new TrieNode[2];
        // No count needed for this specific implementation, as we're modifying in-place
    }

    static class Query {
        int L, R, originalIdx;

        Query(int L, int R, int originalIdx) {
            this.L = L;
            this.R = R;
            this.originalIdx = originalIdx;
        }
    }

    private TrieNode[] segmentTreeTrieRoots; // Array to store Trie roots for segment tree nodes
    private int[] P; // Prefix XOR array

    // Inserts a value into a Trie (modifies in-place)
    private void insertIntoTrie(TrieNode current, int val, int bitPos) {
        if (bitPos < 0) {
            return;
        }
        int bit = (val >> bitPos) & 1;
        if (current.children[bit] == null) {
            current.children[bit] = new TrieNode();
        }
        insertIntoTrie(current.children[bit], val, bitPos - 1);
    }

    // Queries the Trie for maximum XOR with 'val'
    private int getMaxXorFromTrie(TrieNode current, int val, int bitPos) {
        if (current == null || bitPos < 0) {
            return 0;
        }
        int bit = (val >> bitPos) & 1;
        int targetBit = 1 - bit;

        if (current.children[targetBit] != null) {
            return (1 << bitPos) + getMaxXorFromTrie(current.children[targetBit], val, bitPos - 1);
        } else {
            return getMaxXorFromTrie(current.children[bit], val, bitPos - 1);
        }
    }

    // Initializes segment tree nodes with empty Trie roots
    private void initSegmentTree(int nodeIdx, int start, int end) {
        segmentTreeTrieRoots[nodeIdx] = new TrieNode();
        if (start == end) {
            return;
        }
        int mid = (start + end) / 2;
        initSegmentTree(2 * nodeIdx, start, mid);
        initSegmentTree(2 * nodeIdx + 1, mid + 1, end);
    }

    // Updates the segment tree by inserting P[updateIdx] into Tries along the path
    private void updateSegmentTree(int nodeIdx, int start, int end, int updateIdx, int valToInsert) {
        insertIntoTrie(segmentTreeTrieRoots[nodeIdx], valToInsert, MAX_BITS - 1);
        if (start == end) {
            return;
        }
        int mid = (start + end) / 2;
        if (updateIdx <= mid) {
            updateSegmentTree(2 * nodeIdx, start, mid, updateIdx, valToInsert);
        } else {
            updateSegmentTree(2 * nodeIdx + 1, mid + 1, end, updateIdx, valToInsert);
        }
    }

    // Queries the segment tree for max XOR in range [queryL, queryR] with 'val'
    private int querySegmentTreeRangeXor(int nodeIdx, int start, int end, int queryL, int queryR, int val) {
        if (start > queryR || end < queryL) { // No overlap
            return 0;
        }
        if (queryL <= start && end <= queryR) { // Full overlap
            return getMaxXorFromTrie(segmentTreeTrieRoots[nodeIdx], val, MAX_BITS - 1);
        }

        int mid = (start + end) / 2;
        int p1 = querySegmentTreeRangeXor(2 * nodeIdx, start, mid, queryL, queryR, val);
        int p2 = querySegmentTreeRangeXor(2 * nodeIdx + 1, mid + 1, end, queryL, queryR, val);
        return Math.max(p1, p2);
    }

    public int[] maximizeXor(int[] nums, int[][] queries) {
        int N = nums.length;
        P = new int[N + 1]; // P[i] = nums[0] ^ ... ^ nums[i-1], P[0] = 0
        P[0] = 0;
        for (int i = 0; i < N; i++) {
            P[i + 1] = P[i] ^ nums[i];
        }

        List<Query> queryList = new ArrayList<>();
        for (int i = 0; i < queries.length; i++) {
            queryList.add(new Query(queries[i][0], queries[i][1], i));
        }
        // Sort queries by their right endpoint R (which corresponds to k in nums[j..k])
        // The value P[k+1] will be queried, and P[j] will be in range [L, k].
        // So, we sort by R, and when processing P[i], we answer queries where R = i-1.
        // This means we are querying P[i] against P[j] for j in [L, i-1].
        queryList.sort(Comparator.comparingInt(q -> q.R));

        int[] ans = new int[queries.length];
        segmentTreeTrieRoots = new TrieNode[4 * (N + 1)]; // Segment tree for P[0]...P[N]
        initSegmentTree(1, 0, N);

        int currentPIdx = 0; // currentPIdx represents the index 'i' in P[i]
        int queryPtr = 0;

        // Iterate through possible 'k' values (right endpoint of subarray in nums)
        // 'k' in nums[j...k] corresponds to 'i-1' in P[i] ^ P[j]
        // So, 'i' in P[i] will go from 0 to N.
        // When P[i] is added, it means we have considered nums up to index i-1.
        // So, we are ready to answer queries where R = i-1.
        for (int i = 0; i <= N; i++) {
            updateSegmentTree(1, 0, N, i, P[i]); // Add P[i] to the segment tree

            // Process all queries whose R matches current i-1
            while (queryPtr < queryList.size() && queryList.get(queryPtr).R == i - 1) {
                Query q = queryList.get(queryPtr);
                // For query [q.L, q.R]:
                // We need max(P[k+1] ^ P[j]) where q.L <= j <= k <= q.R.
                // Here, k = q.R = i-1. So k+1 = i.
                // The value to query against is P[i].
                // The range for P[j] is [q.L, q.R].
                // This means we need to find max(P[i] ^ P[j]) for j in [q.L, i-1].
                ans[q.originalIdx] = querySegmentTreeRangeXor(1, 0, N, q.L, q.R, P[i]);
                queryPtr++;
            }
        }

        return ans;
    }
}