struct Trie {
    children: [Option<Box<Trie>>; 2],
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: [None, None],
        }
    }

    fn insert(&mut self, num: i32) {
        let mut node = self;
        for i in (0..32).rev() {
            let bit = (num >> i) & 1;
            if node.children[bit as usize].is_none() {
                node.children[bit as usize] = Some(Box::new(Trie::new()));
            }
            node = node.children[bit as usize].as_mut().unwrap();
        }
    }

    fn query(&self, num: i32) -> i32 {
        let mut node = self;
        let mut max_xor = 0;
        for i in (0..32).rev() {
            let bit = (num >> i) & 1;
            let toggle_bit = 1 - bit;
            if node.children[toggle_bit as usize].is_some() {
                max_xor |= 1 << i;
                node = node.children[toggle_bit as usize].as_ref().unwrap();
            } else {
                node = node.children[bit as usize].as_ref().unwrap();
            }
        }
        max_xor
    }
}

pub fn maximum_xor_score(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
    let mut trie = Trie::new();
    let mut results = vec![0; queries.len()];
    let mut indexed_queries: Vec<_> = queries.into_iter().enumerate().collect();
    indexed_queries.sort_by(|a, b| a.1.cmp(&b.1));

    let mut sorted_nums = nums.clone();
    sorted_nums.sort_unstable();

    let mut j = 0;
    for (idx, query) in indexed_queries {
        while j < sorted_nums.len() && sorted_nums[j] <= query {
            trie.insert(sorted_nums[j]);
            j += 1;
        }
        results[idx] = trie.query(query);
    }

    results
}