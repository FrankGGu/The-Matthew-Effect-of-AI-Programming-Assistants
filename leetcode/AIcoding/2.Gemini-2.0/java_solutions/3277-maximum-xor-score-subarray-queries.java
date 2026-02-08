import java.util.Arrays;

class Solution {
    public int[] maxScore(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int q = queries.length;
        int[][] indexedQueries = new int[q][3];
        for (int i = 0; i < q; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = i;
        }
        Arrays.sort(indexedQueries, (a, b) -> b[0] - a[0]);

        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums1[i];
            pairs[i][1] = nums2[i];
        }
        Arrays.sort(pairs, (a, b) -> b[0] - a[0]);

        int[] ans = new int[q];
        Trie trie = new Trie();
        int j = 0;
        for (int i = 0; i < q; i++) {
            int threshold = indexedQueries[i][0];
            int k = indexedQueries[i][1];
            int index = indexedQueries[i][2];

            while (j < n && pairs[j][0] >= threshold) {
                trie.insert(pairs[j][1]);
                j++;
            }

            ans[index] = trie.getMaxXor(k);
        }

        return ans;
    }

    class Trie {
        TrieNode root;

        public Trie() {
            root = new TrieNode();
        }

        public void insert(int num) {
            TrieNode node = root;
            for (int i = 31; i >= 0; i--) {
                int bit = (num >> i) & 1;
                if (node.children[bit] == null) {
                    node.children[bit] = new TrieNode();
                }
                node = node.children[bit];
            }
        }

        public int getMaxXor(int num) {
            TrieNode node = root;
            int maxXor = 0;
            for (int i = 31; i >= 0; i--) {
                int bit = (num >> i) & 1;
                if (node.children[1 - bit] != null) {
                    maxXor |= (1 << i);
                    node = node.children[1 - bit];
                } else if (node.children[bit] != null) {
                    node = node.children[bit];
                } else {
                    return 0;
                }
            }
            return maxXor;
        }
    }

    class TrieNode {
        TrieNode[] children;

        public TrieNode() {
            children = new TrieNode[2];
        }
    }
}