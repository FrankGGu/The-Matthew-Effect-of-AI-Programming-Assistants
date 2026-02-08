class Solution {
    class TrieNode {
        TrieNode[] children;
        int count;
        public TrieNode() {
            children = new TrieNode[2];
            count = 0;
        }
    }

    private void insert(TrieNode root, int num) {
        TrieNode node = root;
        for (int i = 14; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[bit] == null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
            node.count++;
        }
    }

    private int countLessThan(TrieNode root, int num, int limit) {
        TrieNode node = root;
        int res = 0;
        for (int i = 14; i >= 0 && node != null; i--) {
            int bitNum = (num >> i) & 1;
            int bitLimit = (limit >> i) & 1;
            if (bitLimit == 1) {
                if (node.children[bitNum] != null) {
                    res += node.children[bitNum].count;
                }
                node = node.children[1 - bitNum];
            } else {
                node = node.children[bitNum];
            }
        }
        return res;
    }

    public int countPairs(int[] nums, int low, int high) {
        TrieNode root = new TrieNode();
        int res = 0;
        for (int num : nums) {
            res += countLessThan(root, num, high + 1) - countLessThan(root, num, low);
            insert(root, num);
        }
        return res;
    }
}