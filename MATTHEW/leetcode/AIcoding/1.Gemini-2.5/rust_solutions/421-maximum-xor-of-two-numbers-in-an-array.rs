struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
        }
    }
}

impl Solution {
    pub fn find_maximum_xor(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut root = TrieNode::new();
        let max_bit = 30; // For numbers up to 2^31 - 1, we consider bits from 30 down to 0.

        // Insert all numbers into the Trie
        for &num in nums.iter() {
            let mut curr = &mut root;
            for i in (0..=max_bit).rev() {
                let bit = ((num >> i) & 1) as usize;
                if curr.children[bit].is_none() {
                    curr.children[bit] = Some(Box::new(TrieNode::new()));
                }
                curr = curr.children[bit].as_mut().unwrap();
            }
        }

        let mut max_xor = 0;

        // For each number, find the maximum XOR pair
        for &num in nums.iter() {
            let mut curr = &root;
            let mut current_xor = 0;
            for i in (0..=max_bit).rev() {
                let bit = ((num >> i) & 1) as usize;
                let opposite_bit = 1 - bit;

                if let Some(node) = curr.children[opposite_bit].as_ref() {
                    current_xor |= (1 << i);
                    curr = node;
                } else {
                    // If the opposite bit path doesn't exist, we must take the same bit path.
                    // This path must exist because all numbers are inserted into the Trie.
                    curr = curr.children[bit].as_ref().unwrap();
                }
            }
            max_xor = max_xor.max(current_xor);
        }

        max_xor
    }
}