class Solution {
    static class TrieNode {
        TrieNode[] children = new TrieNode[2];
    }

    public int maximumStrongPairXor(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        TrieNode root = new TrieNode();
        int left = 0;
        int ans = 0;

        for (int right = 0; right < n; right++) {
            int val = nums[right];
            insert(root, val);

            while (nums[left] * 2 < val) {
                remove(root, nums[left]);
                left++;
            }

            ans = Math.max(ans, maxXor(root, val));
        }

        return ans;
    }

    private void insert(TrieNode root, int num) {
        TrieNode node = root;
        for (int i = 19; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[bit] == null) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    }

    private void remove(TrieNode root, int num) {
        TrieNode node = root;
        TrieNode[] path = new TrieNode[20];
        int[] bits = new int[20];
        for (int i = 19; i >= 0; i--) {
            int bit = (num >> i) & 1;
            path[i] = node;
            bits[i] = bit;
            node = node.children[bit];
        }

        for (int i = 0; i < 2; i++) {
            node = root;
            for (int j = 19; j >= 0; j--) {
                int bit = (num >> j) & 1;
                if (node.children[bit] == null) {
                    return;
                }
                node = node.children[bit];
            }
        }

        node = root;
        for (int i = 19; i >= 0; i--) {
            int bit = bits[i];
            if (path[i].children[bit].children[0] == null && path[i].children[bit].children[1] == null) {
                path[i].children[bit] = null;
                return;
            } else {
                node = path[i].children[bit];
            }
        }
    }

    private int maxXor(TrieNode root, int num) {
        TrieNode node = root;
        int xor = 0;
        for (int i = 19; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (node.children[1 - bit] != null) {
                xor |= (1 << i);
                node = node.children[1 - bit];
            } else {
                node = node.children[bit];
            }
        }
        return xor;
    }
}