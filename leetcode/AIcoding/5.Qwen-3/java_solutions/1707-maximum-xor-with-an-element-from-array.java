public class Solution {

import java.util.*;

public class Solution {
    public int[] maximizeXor(int[] nums, int[] queries) {
        Arrays.sort(nums);
        int[][] sortedQueries = new int[queries.length][3];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i][0] = queries[i];
            sortedQueries[i][1] = i;
        }
        Arrays.sort(sortedQueries, (a, b) -> a[0] - b[0]);

        Trie trie = new Trie();
        int[] result = new int[queries.length];
        int idx = 0;

        for (int[] q : sortedQueries) {
            int x = q[0];
            int originalIndex = q[1];
            while (idx < nums.length && nums[idx] <= x) {
                trie.insert(nums[idx]);
                idx++;
            }
            result[originalIndex] = trie.maxXor(x);
        }

        return result;
    }

    static class Trie {
        private TrieNode root;

        public Trie() {
            root = new TrieNode();
        }

        public void insert(int num) {
            TrieNode node = root;
            for (int i = 30; i >= 0; i--) {
                int bit = (num >> i) & 1;
                if (node.children[bit] == null) {
                    node.children[bit] = new TrieNode();
                }
                node = node.children[bit];
            }
        }

        public int maxXor(int num) {
            TrieNode node = root;
            int max = 0;
            for (int i = 30; i >= 0; i--) {
                int bit = (num >> i) & 1;
                int toggleBit = 1 - bit;
                if (node.children[toggleBit] != null) {
                    max |= (1 << i);
                    node = node.children[toggleBit];
                } else {
                    node = node.children[bit];
                }
            }
            return max;
        }

        static class TrieNode {
            TrieNode[] children;

            public TrieNode() {
                children = new TrieNode[2];
            }
        }
    }
}
}