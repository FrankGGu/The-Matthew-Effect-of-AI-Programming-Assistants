import java.util.Arrays;
import java.util.Comparator;

class Solution {

    static class TrieNode {
        TrieNode[] children;

        public TrieNode() {
            children = new TrieNode[2]; // 0 and 1
        }
    }

    static class Trie {
        TrieNode root;

        public Trie() {
            root = new TrieNode();
        }

        public void insert(int num) {
            TrieNode curr = root;
            for (int i = 29; i >= 0; i--) { // Iterate from MSB (29th bit for numbers up to 10^9 < 2^30)
                int bit = (num >> i) & 1;
                if (curr.children[bit] == null) {
                    curr.children[bit] = new TrieNode();
                }
                curr = curr.children[bit];
            }
        }

        public int getMaxXor(int num) {
            TrieNode curr = root;
            int maxXor = 0;
            for (int i = 29; i >= 0; i--) {
                int bit = (num >> i) & 1;
                int desiredBit = 1 - bit;

                if (curr.children[desiredBit] != null) {
                    maxXor |= (1 << i);
                    curr = curr.children[desiredBit];
                } else {
                    curr = curr.children[bit];
                }
            }
            return maxXor;
        }
    }

    static class Query {
        int x;
        int limit;
        int originalIndex;

        public Query(int x, int limit, int originalIndex) {
            this.x = x;
            this.limit = limit;
            this.originalIndex = originalIndex;
        }
    }

    public int[] maximizeXor(int[] nums, int[][] queriesArr) {
        Arrays.sort(nums);

        Query[] queries = new Query[queriesArr.length];
        for (int i = 0; i < queriesArr.length; i++) {
            queries[i] = new Query(queriesArr[i][0], queriesArr[i][1], i);
        }
        Arrays.sort(queries, Comparator.comparingInt(q -> q.limit));

        int[] results = new int[queriesArr.length];
        Trie trie = new Trie();
        int numsIdx = 0;

        for (Query q : queries) {
            while (numsIdx < nums.length && nums[numsIdx] <= q.limit) {
                trie.insert(nums[numsIdx]);
                numsIdx++;
            }

            if (numsIdx == 0) {
                results[q.originalIndex] = -1;
            } else {
                results[q.originalIndex] = trie.getMaxXor(q.x);
            }
        }

        return results;
    }
}