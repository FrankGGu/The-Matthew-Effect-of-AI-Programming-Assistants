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
    const MAX_BITS: usize = 30; // For numbers up to 2^31 - 1, the most significant bit is at index 30.

    fn insert(root: &mut TrieNode, num: i32) {
        let mut current = root;
        for i in (0..=Self::MAX_BITS).rev() {
            let bit = ((num >> i) & 1) as usize;
            if current.children[bit].is_none() {
                current.children[bit] = Some(Box::new(TrieNode::new()));
            }
            current = current.children[bit].as_mut().unwrap();
        }
    }

    fn find_max_xor_for_num(root: &TrieNode, num: i32) -> i32 {
        let mut current = root;
        let mut current_xor = 0;
        for i in (0..=Self::MAX_BITS).rev() {
            let bit = ((num >> i) & 1) as usize;
            let desired_bit = 1 - bit; // To maximize XOR, we want the opposite bit

            if let Some(ref child) = current.children[desired_bit] {
                current_xor |= (1 << i); // Set this bit in current_xor
                current = child;
            } else {
                // If the desired opposite bit path doesn't exist, we must take the same bit path.
                // This path must exist because all numbers (including 'num' itself) are inserted.
                current = current.children[bit].as_ref().unwrap();
            }
        }
        current_xor
    }

    pub fn find_maximum_xor(nums: Vec<i32>) -> i32 {
        let mut root = TrieNode::new();

        for &num in &nums {
            Self::insert(&mut root, num);
        }

        let mut max_xor = 0;
        for &num in &nums {
            max_xor = max_xor.max(Self::find_max_xor_for_num(&root, num));
        }

        max_xor
    }
}