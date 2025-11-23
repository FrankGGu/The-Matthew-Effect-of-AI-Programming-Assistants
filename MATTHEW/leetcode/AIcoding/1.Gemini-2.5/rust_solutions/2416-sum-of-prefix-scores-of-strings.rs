struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::array::from_fn(|_| None),
            count: 0,
        }
    }
}

impl Solution {
    pub fn sum_prefix_scores(words: Vec<String>) -> Vec<i32> {
        let mut root = TrieNode::new();

        for word in &words {
            let mut current_node = &mut root;
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                if current_node.children[idx].is_none() {
                    current_node.children[idx] = Some(Box::new(TrieNode::new()));
                }
                current_node = current_node.children[idx].as_mut().unwrap();
                current_node.count += 1;
            }
        }

        let mut scores = Vec::with_capacity(words.len());
        for word in &words {
            let mut current_node = &root;
            let mut current_score = 0;
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                current_node = current_node.children[idx].as_ref().unwrap();
                current_score += current_node.count;
            }
            scores.push(current_score);
        }

        scores
    }
}