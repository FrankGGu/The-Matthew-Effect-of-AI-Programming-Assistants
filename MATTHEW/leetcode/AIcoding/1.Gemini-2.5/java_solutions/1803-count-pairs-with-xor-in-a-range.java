class Solution {
    private static final int MAX_BITS = 14; // Numbers are up to 2 * 10^4. 2^14 = 16384, 2^15 = 32768. So, bits from 0 to 14 are sufficient.

    class TrieNode {
        TrieNode[] children;
        int count; // Number of elements whose prefix matches up to this node

        TrieNode() {
            children = new TrieNode[2]; // children[0] for bit 0, children[1] for bit 1
            count = 0;
        }
    }

    TrieNode root;

    public Solution() {
        root = new TrieNode();
    }

    // Inserts a number into the Trie
    public void insert(int num) {
        TrieNode curr = root;
        curr.count++; // Increment count for the root node
        for (int i = MAX_BITS; i >= 0; i--) {
            int bit = (num >> i) & 1;
            if (curr.children[bit] == null) {
                curr.children[bit] = new TrieNode();
            }
            curr = curr.children[bit];
            curr.count++; // Increment count for the current node
        }
    }

    // Counts how many numbers 'x' in the Trie satisfy (x XOR num) <= limit
    public int query(int num, int limit) {
        if (limit < 0) {
            return 0; // No XOR sum can be less than 0.
        }

        TrieNode curr = root;
        int ans = 0;

        for (int i = MAX_BITS; i >= 0; i--) {
            if (curr == null) {
                // If we hit a null node, it means no numbers in the Trie match the path taken so far.
                break;
            }

            int num_bit = (num >> i) & 1;
            int limit_bit = (limit >> i) & 1;

            if (limit_bit == 1) {
                // If the limit bit is 1, we have two possibilities for the current XOR bit:
                // 1. XOR bit is 0: This happens if the current number's bit (x_bit) is equal to num_bit.
                //    Since 0 < 1, all numbers in the subtree of curr.children[num_bit] will satisfy
                //    the condition for this bit and all lower bits (as 0 is always <= 1).
                if (curr.children[num_bit] != null) {
                    ans += curr.children[num_bit].count;
                }
                // 2. XOR bit is 1: This happens if x_bit is not equal to num_bit.
                //    We must continue down this path, checking if the remaining bits satisfy the remaining limit.
                curr = curr.children[1 - num_bit];
            } else { // limit_bit == 0
                // If the limit bit is 0, the current XOR bit MUST be 0.
                // This happens if x_bit is equal to num_bit.
                // If x_bit were not equal to num_bit, the XOR bit would be 1, which is > 0, violating the limit.
                // So, we must only go down the path where x_bit == num_bit.
                curr = curr.children[num_bit];
            }
        }

        // After iterating through all bits, if curr is not null, it means the path taken
        // (which results in XOR sum <= limit) has been successfully traversed to this node.
        // All numbers in the subtree rooted at 'curr' satisfy the condition.
        if (curr != null) {
            ans += curr.count;
        }

        return ans;
    }

    public int countPairs(int[] nums, int low, int high) {
        // The problem asks for low <= (nums[i] XOR nums[j]) <= high
        // This can be broken down into:
        // (count of pairs where XOR sum <= high) - (count of pairs where XOR sum < low)
        // Which is equivalent to:
        // (count of pairs where XOR sum <= high) - (count of pairs where XOR sum <= low - 1)

        int totalPairs = 0;

        // Re-initialize Trie for each call to countPairs
        // (LeetCode creates a new Solution object for each test case, so this is fine)
        this.root = new TrieNode();

        for (int num : nums) {
            totalPairs += query(num, high);
            totalPairs -= query(num, low - 1);
            insert(num);
        }

        return totalPairs;
    }
}