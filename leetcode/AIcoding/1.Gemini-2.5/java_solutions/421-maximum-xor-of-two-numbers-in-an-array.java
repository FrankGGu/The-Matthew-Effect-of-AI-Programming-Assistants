class Solution {
    private static class TrieNode {
        TrieNode[] children = new TrieNode[2];
    }

    private TrieNode root;
    private static final int BITS = 30;

    public int findMaximumXOR(int[] nums) {
        root = new TrieNode();

        for (int num : nums) {
            insert(num);
        }

        int maxXOR = 0;
        for (int num : nums) {
            maxXOR = Math.max(maxXOR, findMaxXorPair(num));
        }

        return maxXOR;
    }

    private void insert(int num) {
        TrieNode curr = root;
        for (int i = BITS; i >= 0; i--) {
            int bit = (num >>> i) & 1;
            if (curr.children[bit] == null) {
                curr.children[bit] = new TrieNode();
            }
            curr = curr.children[bit];
        }
    }

    private int findMaxXorPair(int num) {
        TrieNode curr = root;
        int currentXOR = 0;
        for (int i = BITS; i >= 0; i--) {
            int bit = (num >>> i) & 1;
            int desiredBit = 1 - bit;

            if (curr.children[desiredBit] != null) {
                currentXOR |= (1 << i);
                curr = curr.children[desiredBit];
            } else {
                curr = curr.children[bit];
            }
        }
        return currentXOR;
    }
}