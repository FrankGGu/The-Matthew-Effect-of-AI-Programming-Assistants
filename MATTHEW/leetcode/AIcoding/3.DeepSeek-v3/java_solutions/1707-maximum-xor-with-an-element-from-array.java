class Solution {
    class TrieNode {
        TrieNode[] children;
        public TrieNode() {
            children = new TrieNode[2];
        }
    }

    public int[] maximizeXor(int[] nums, int[][] queries) {
        int[] res = new int[queries.length];
        Arrays.sort(nums);
        int[][] qs = new int[queries.length][3];
        for (int i = 0; i < queries.length; i++) {
            qs[i][0] = queries[i][0];
            qs[i][1] = queries[i][1];
            qs[i][2] = i;
        }
        Arrays.sort(qs, (a, b) -> a[1] - b[1]);
        TrieNode root = new TrieNode();
        int idx = 0;
        for (int[] q : qs) {
            int x = q[0], m = q[1], qid = q[2];
            while (idx < nums.length && nums[idx] <= m) {
                insert(root, nums[idx]);
                idx++;
            }
            if (idx == 0) {
                res[qid] = -1;
            } else {
                res[qid] = getMaxXor(root, x);
            }
        }
        return res;
    }

    private void insert(TrieNode root, int num) {
        TrieNode node = root;
        for (int i = 31; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[bit] == null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    }

    private int getMaxXor(TrieNode root, int num) {
        TrieNode node = root;
        int res = 0;
        for (int i = 31; i >= 0; i--) {
            int bit = (num >> i) & 1;
            int toggleBit = 1 - bit;
            if (node.children[toggleBit] != null) {
                res |= (1 << i);
                node = node.children[toggleBit];
            } else {
                node = node.children[bit];
            }
        }
        return res;
    }
}