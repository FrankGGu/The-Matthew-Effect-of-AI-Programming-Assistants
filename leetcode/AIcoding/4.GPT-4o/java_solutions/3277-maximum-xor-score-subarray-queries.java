class Solution {
    public int[] maximizeXor(int[] nums, int[][] queries) {
        int n = nums.length, m = queries.length;
        int[][] queryWithIndex = new int[m][3];
        for (int i = 0; i < m; i++) {
            queryWithIndex[i][0] = queries[i][0];
            queryWithIndex[i][1] = queries[i][1];
            queryWithIndex[i][2] = i;
        }
        Arrays.sort(queryWithIndex, (a, b) -> Integer.compare(a[1], b[1]));
        Arrays.sort(nums);

        int[] result = new int[m];
        int maxXor = 0;
        TrieNode root = new TrieNode();
        int idx = 0;

        for (int[] query : queryWithIndex) {
            int limit = query[1];
            while (idx < n && nums[idx] <= limit) {
                insert(root, nums[idx]);
                idx++;
            }
            result[query[2]] = idx == 0 ? -1 : maxXor(root, query[0]);
        }

        return result;
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
        node.value = num;
    }

    private int maxXor(TrieNode root, int num) {
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

    class TrieNode {
        TrieNode[] children = new TrieNode[2];
        int value;
    }
}