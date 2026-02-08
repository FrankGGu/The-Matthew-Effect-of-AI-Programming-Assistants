import java.util.Arrays;

class Solution {

    // TrieNode class to represent a node in the Trie
    static class TrieNode {
        TrieNode[] children = new TrieNode[2]; // children[0] for bit 0, children[1] for bit 1
        int count = 0; // Number of elements passing through this node
    }

    // Trie class for insertion, removal, and max XOR queries
    static class Trie {
        TrieNode root;
        static final int BITS = 30; // Max value of nums[i] is 10^9, which requires up to 30 bits (2^29 < 10^9 < 2^30)

        public Trie() {
            root = new TrieNode();
        }

        // Inserts a number into the Trie
        public void insert(int num) {
            TrieNode node = root;
            for (int i = BITS - 1; i >= 0; i--) {
                int bit = (num >> i) & 1;
                if (node.children[bit] == null) {
                    node.children[bit] = new TrieNode();
                }
                node = node.children[bit];
                node.count++; // Increment count for all nodes on the path
            }
        }

        // Removes a number from the Trie
        public void remove(int num) {
            TrieNode node = root;
            for (int i = BITS - 1; i >= 0; i--) {
                int bit = (num >> i) & 1;
                // Assuming the path exists because num was previously inserted
                node = node.children[bit];
                node.count--; // Decrement count for all nodes on the path
            }
        }

        // Finds the maximum XOR value with the given number among numbers currently in the Trie
        public int getMaxXor(int num) {
            TrieNode node = root;
            int currentXor = 0;
            for (int i = BITS - 1; i >= 0; i--) {
                int bit = (num >> i) & 1;
                int desiredBit = 1 - bit; // We want the opposite bit to maximize XOR

                // If a path with the desired bit exists and has active numbers
                if (node.children[desiredBit] != null && node.children[desiredBit].count > 0) {
                    currentXor |= (1 << i); // Set this bit in currentXor
                    node = node.children[desiredBit];
                } else {
                    // Otherwise, we must take the same bit. This path must exist
                    // because 'num' itself is in the Trie, ensuring its path is valid.
                    // Also, the Trie will always contain at least one element (the current 'y' being processed).
                    node = node.children[bit];
                }
            }
            return currentXor;
        }
    }

    public int maximumStrongPairXor(int[] nums) {
        Arrays.sort(nums); // Sort the array to use the sliding window approach

        Trie trie = new Trie();
        int max_xor = 0;
        int left = 0;

        // Iterate with the right pointer (y)
        for (int right = 0; right < nums.length; right++) {
            int y = nums[right];

            // Adjust the left pointer (x) to maintain the strong pair condition: x >= y / 2
            // Remove numbers from the Trie that are too small for the current y
            while (left < right && nums[left] < (double) y / 2) { // Use double for accurate division
                trie.remove(nums[left]);
                left++;
            }

            // Add the current number (y) to the Trie
            trie.insert(y);

            // Query the Trie for the maximum XOR with y among the valid x's
            max_xor = Math.max(max_xor, trie.getMaxXor(y));
        }

        return max_xor;
    }
}