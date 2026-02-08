import java.util.Arrays;

class TrieNode {
    TrieNode[] children;

    public TrieNode() {
        children = new TrieNode[2];
    }
}

class Trie {
    TrieNode root;
    int L = 30;

    public Trie() {
        root = new TrieNode();
    }

    public void insert(int num) {
        TrieNode node = root;
        for (int i = L - 1; i >= 0; i--) {
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
        for (int i = L - 1; i >= 0; i--) {
            int bit = (num >> i) & 1;
            int oppositeBit = 1 - bit;
            if (node.children[oppositeBit] != null) {
                maxXor |= (1 << i);
                node = node.children[oppositeBit];
            } else {
                node = node.children[bit];
            }
        }
        return maxXor;
    }
}

class Solution {
    public int[] maximizeXor(int[] nums, int[][] queries) {
        Arrays.sort(nums);

        int[][] sortedQueries = new int[queries.length][3];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i][0] = queries[i][0];
            sortedQueries[i][1] = queries[i][1];
            sortedQueries[i][2] = i;
        }
        Arrays.sort(sortedQueries, (a, b) -> a[1] - b[1]);

        int[] ans = new int[queries.length];
        Arrays.fill(ans, -1);

        Trie trie = new Trie();
        int numsIdx = 0;

        for (int[] query : sortedQueries) {
            int xi = query[0];
            int mi = query[1];
            int originalIndex = query[2];

            while (numsIdx < nums.length && nums[numsIdx] <= mi) {
                trie.insert(nums[numsIdx]);
                numsIdx++;
            }

            if (numsIdx > 0 && nums[numsIdx - 1] <= mi) {
                ans[originalIndex] = trie.getMaxXor(xi);
            }
        }

        return ans;
    }
}