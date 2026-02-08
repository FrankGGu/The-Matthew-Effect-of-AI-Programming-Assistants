class Solution {
    private static class TrieNode {
        TrieNode[] children;

        public TrieNode() {
            children = new TrieNode[2]; // 0 or 1
        }
    }

    public int findMaximumXOR(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        TrieNode root = new TrieNode();
        for (int num : nums) {
            TrieNode node = root;
            for (int i = 30; i >= 0; i--) {
                int bit = (num >>> i) & 1;
                if (node.children[bit] == null) {
                    node.children[bit] = new TrieNode();
                }
                node = node.children[bit];
            }
        }

        int max_xor = 0;
        for (int num : nums) {
            TrieNode node = root;
            int current_xor = 0;
            for (int i = 30; i >= 0; i--) {
                int bit = (num >>> i) & 1;
                int opposite_bit = 1 - bit;

                if (node.children[opposite_bit] != null) {
                    current_xor |= (1 << i);
                    node = node.children[opposite_bit];
                } else {
                    node = node.children[bit];
                }
            }
            max_xor = Math.max(max_xor, current_xor);
        }

        return max_xor;
    }
}