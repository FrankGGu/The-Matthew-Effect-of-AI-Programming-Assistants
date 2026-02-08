class TrieNode {
    TrieNode[] children = new TrieNode[2];
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

    public int maxXor(int num) {
        TrieNode node = root;
        int maxXor = 0;
        for (int i = 31; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[1 - bit] != null) {
                maxXor |= (1 << i);
                node = node.children[1 - bit];
            } else {
                node = node.children[bit];
            }
        }
        return maxXor;
    }
}

class Solution {
    public int[] maximizeXor(int[] nums, int[][] queries) {
        int n = nums.length;
        int q = queries.length;
        int[][] indexedQueries = new int[q][3];
        for (int i = 0; i < q; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = i;
        }
        Arrays.sort(nums);
        Arrays.sort(indexedQueries, (a, b) -> Integer.compare(a[1], b[1]));

        int[] result = new int[q];
        Trie trie = new Trie();
        int j = 0;

        for (int i = 0; i < q; i++) {
            while (j < n && nums[j] <= indexedQueries[i][1]) {
                trie.insert(nums[j]);
                j++;
            }
            if (j == 0) {
                result[indexedQueries[i][2]] = -1;
            } else {
                result[indexedQueries[i][2]] = trie.maxXor(indexedQueries[i][0]);
            }
        }

        return result;
    }
}