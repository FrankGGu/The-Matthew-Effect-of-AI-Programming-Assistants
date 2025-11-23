use std::collections::BinaryHeap;
use std::cmp::Reverse;

const INF: i64 = i64::MAX;

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    min_cost_if_word_ends_here: i64,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::array::from_fn(|_| None),
            min_cost_if_word_ends_here: INF,
        }
    }
}

impl Solution {
    pub fn minimum_cost(target: String, words: Vec<String>, costs: Vec<i32>) -> i64 {
        let mut root = TrieNode::new();

        for (i, word) in words.iter().enumerate() {
            let cost = costs[i] as i64;
            let mut curr = &mut root;
            for &c in word.as_bytes() {
                let idx = (c - b'a') as usize;
                curr = curr.children[idx].get_or_insert_with(TrieNode::new);
            }
            curr.min_cost_if_word_ends_here = curr.min_cost_if_word_ends_here.min(cost);
        }

        let n = target.len();
        let target_bytes = target.as_bytes();
        let mut dp = vec![INF; n + 1];
        dp[0] = 0;

        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0))); // (cost, index)

        while let Some(Reverse((cost, u))) = pq.pop() {
            if cost > dp[u] {
                continue;
            }

            let mut curr_trie_node = &root;
            for k in u..n {
                let char_idx = (target_bytes[k] - b'a') as usize;

                if let Some(child_node) = curr_trie_node.children[char_idx].as_deref() {
                    curr_trie_node = child_node;

                    if curr_trie_node.min_cost_if_word_ends_here != INF {
                        let end_idx = k + 1;
                        let new_cost = dp[u] + curr_trie_node.min_cost_if_word_ends_here;

                        if new_cost < dp[end_idx] {
                            dp[end_idx] = new_cost;
                            pq.push(Reverse((new_cost, end_idx)));
                        }
                    }
                } else {
                    break;
                }
            }
        }

        if dp[n] == INF {
            -1
        } else {
            dp[n]
        }
    }
}