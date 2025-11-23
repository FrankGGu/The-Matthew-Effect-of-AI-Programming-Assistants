struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
    count: usize,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
            count: 0,
        }
    }
}

const MAX_BITS: usize = 29; // For numbers up to 10^9 (2^29 to 2^30-1), we need bits from 0 to 29.

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: TrieNode::new(),
        }
    }

    fn insert(&mut self, num: i32) {
        let mut curr = &mut self.root;
        for i in (0..=MAX_BITS).rev() {
            curr.count += 1;
            let bit = ((num >> i) & 1) as usize;
            if curr.children[bit].is_none() {
                curr.children[bit] = Some(Box::new(TrieNode::new()));
            }
            curr = curr.children[bit].as_mut().unwrap();
        }
        curr.count += 1;
    }

    fn remove(&mut self, num: i32) {
        let mut curr = &mut self.root;
        for i in (0..=MAX_BITS).rev() {
            curr.count -= 1;
            let bit = ((num >> i) & 1) as usize;
            curr = curr.children[bit].as_mut().unwrap();
        }
        curr.count -= 1;
    }

    fn find_max_xor(&self, num: i32) -> i32 {
        let mut curr = &self.root;
        let mut current_xor = 0;
        if curr.count == 0 {
            return 0;
        }

        for i in (0..=MAX_BITS).rev() {
            let bit = ((num >> i) & 1) as usize;
            let desired_bit = 1 - bit;

            if let Some(child_node) = &curr.children[desired_bit] {
                if child_node.count > 0 {
                    current_xor |= (1 << i);
                    curr = child_node;
                    continue;
                }
            }

            if let Some(child_node) = &curr.children[bit] {
                if child_node.count > 0 {
                    curr = child_node;
                } else {
                    break; 
                }
            } else {
                break;
            }
        }
        current_xor
    }
}

impl Solution {
    pub fn maximum_strong_pair_xor(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mut max_xor = 0;
        let mut trie = Trie::new();
        let mut left = 0;

        for right in 0..n {
            let current_num = nums[right];

            while left < right && 2 * nums[left] < current_num {
                trie.remove(nums[left]);
                left += 1;
            }

            trie.insert(current_num);
            max_xor = max_xor.max(trie.find_max_xor(current_num));
        }

        max_xor
    }
}