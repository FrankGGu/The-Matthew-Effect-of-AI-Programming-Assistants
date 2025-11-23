struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None],
            count: 0,
        }
    }
}

const MAX_BITS: usize = 15; // Numbers up to 2 * 10^4 require 15 bits (0 to 14)

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
        for i in (0..MAX_BITS).rev() {
            let bit = ((num >> i) & 1) as usize;
            curr.count += 1;
            if curr.children[bit].is_none() {
                curr.children[bit] = Some(Box::new(TrieNode::new()));
            }
            curr = curr.children[bit].as_mut().unwrap();
        }
        curr.count += 1;
    }

    fn count_less_than(&self, x: i32, limit: i32) -> i32 {
        let mut count = 0;
        let mut curr_opt = Some(&self.root);

        for i in (0..MAX_BITS).rev() {
            let curr = match curr_opt {
                Some(node) => node,
                None => break,
            };

            let x_bit = ((x >> i) & 1) as usize;
            let limit_bit = ((limit >> i) & 1) as usize;

            if limit_bit == 1 {
                if let Some(node) = &curr.children[x_bit] {
                    count += node.count;
                }
                curr_opt = curr.children[x_bit ^ 1].as_ref().map(|n| &**n);
            } else {
                curr_opt = curr.children[x_bit].as_ref().map(|n| &**n);
            }
        }
        count
    }
}

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, low: i32, high: i32) -> i32 {
        let mut total_pairs = 0;
        let mut trie = Trie::new();

        for &num in nums.iter() {
            let count_less_than_high_plus_1 = trie.count_less_than(num, high + 1);
            let count_less_than_low = trie.count_less_than(num, low);

            total_pairs += count_less_than_high_plus_1 - count_less_than_low;

            trie.insert(num);
        }

        total_pairs
    }
}