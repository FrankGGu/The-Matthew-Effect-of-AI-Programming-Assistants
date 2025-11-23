class TrieNode {
    constructor() {
        this.children = [null, null]; // children[0] for bit 0, children[1] for bit 1
        this.count = 0; // Number of elements passing through this node
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
        this.MAX_BIT_INDEX = 30; // Numbers up to 2 * 10^9 require considering bits up to index 30.
                                 // (2^30 is ~10^9, 2^31 is ~2*10^9).
    }

    insert(num) {
        let curr = this.root;
        for (let i = this.MAX_BIT_INDEX; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (curr.children[bit] === null) {
                curr.children[bit] = new TrieNode();
            }
            curr = curr.children[bit];
            curr.count++; // Increment count for numbers passing through this node
        }
    }

    // Counts numbers 'y' in the Trie such that (num ^ y) <= limit
    count_less_equal(num, limit) {
        let curr = this.root;
        let ans = 0;
        for (let i = this.MAX_BIT_INDEX; i >= 0; i--) {
            if (curr === null) {
                // If we ran out of nodes in the Trie path, no more numbers can be found.
                break;
            }

            const bit_num = (num >> i) & 1;
            const bit_limit = (limit >> i) & 1;

            if (bit_limit === 1) {
                // If current bit of limit is 1:
                // Option 1: Make (num ^ y) have 0 at this bit.
                // This means y should be `bit_num`.
                // If curr.children[bit_num] exists, all numbers in that subtree
                // will result in 0 at this bit for (num ^ y).
                // Since 0 < 1, these numbers are definitely <= limit for this bit and higher.
                // Add their count to ans.
                if (curr.children[bit_num] !== null) {
                    ans += curr.children[bit_num].count;
                }
                // Option 2: Make (num ^ y) have 1 at this bit.
                // This means y should be `1 - bit_num`.
                // We must continue down this path to potentially match 'limit' exactly or be less.
                curr = curr.children[1 - bit_num];
            } else { // bit_limit === 0
                // If current bit of limit is 0:
                // Option 1: Make (num ^ y) have 1 at this bit.
                // This means y should be `1 - bit_num`.
                // This path would make (num ^ y) greater than limit at this bit (1 > 0).
                // So, we cannot take this path.
                // Option 2: Make (num ^ y) have 0 at this bit.
                // This means y should be `bit_num`.
                // We must continue down this path to potentially match 'limit' exactly or be less.
                curr = curr.children[bit_num];
            }
        }
        return ans;
    }
}

var countPairs = function(nums, low, high) {
    const trie = new Trie();
    let totalPairs = 0;

    // Iterate through nums, for each num, query the trie for previously seen numbers
    // and then insert num into the trie. This ensures each pair (nums[i], nums[j]) with i < j is counted exactly once.
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        // Count y such that (num ^ y) <= high, then subtract y such that (num ^ y) < low.
        // (num ^ y) < low is equivalent to (num ^ y) <= (low - 1).
        totalPairs += trie.count_less_equal(num, high) - trie.count_less_equal(num, low - 1);
        trie.insert(num);
    }

    return totalPairs;
};