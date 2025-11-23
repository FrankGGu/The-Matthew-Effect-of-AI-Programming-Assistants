struct Node {
    len: usize,
    prefix_char: char,
    prefix_len: usize,
    suffix_char: char,
    suffix_len: usize,
    max_len: usize,
}

impl Node {
    fn new_leaf(c: char) -> Self {
        Node {
            len: 1,
            prefix_char: c,
            prefix_len: 1,
            suffix_char: c,
            suffix_len: 1,
            max_len: 1,
        }
    }

    fn merge(left: &Node, right: &Node) -> Self {
        let len = left.len + right.len;

        let mut prefix_char = left.prefix_char;
        let mut prefix_len = left.prefix_len;
        if left.prefix_len == left.len && left.prefix_char == right.prefix_char {
            prefix_len += right.prefix_len;
        }

        let mut suffix_char = right.suffix_char;
        let mut suffix_len = right.suffix_len;
        if right.suffix_len == right.len && right.suffix_char == left.suffix_char {
            suffix_len += left.suffix_len;
        }

        let mut max_len = left.max_len.max(right.max_len);
        if left.suffix_char == right.prefix_char {
            max_len = max_len.max(left.suffix_len + right.prefix_len);
        }

        Node {
            len,
            prefix_char,
            prefix_len,
            suffix_char,
            suffix_len,
            max_len,
        }
    }
}

struct SegmentTree {
    tree: Vec<Node>,
    n: usize,
    s_chars: Vec<char>,
}

impl SegmentTree {
    fn new(s: String) -> Self {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut tree = vec![
            Node {
                len: 0,
                prefix_char: ' ',
                prefix_len: 0,
                suffix_char: ' ',
                suffix_len: 0,
                max_len: 0
            };
            4 * n
        ];

        let mut st = SegmentTree { tree, n, s_chars };
        st.build(0, 0, n - 1);
        st
    }

    fn build(&mut self, node_idx: usize, start: usize, end: usize) {
        if start == end {
            self.tree[node_idx] = Node::new_leaf(self.s_chars[start]);
        } else {
            let mid = start + (end - start) / 2;
            self.build(2 * node_idx + 1, start, mid);
            self.build(2 * node_idx + 2, mid + 1, end);
            self.tree[node_idx] = Node::merge(&self.tree[2 * node_idx + 1], &self.tree[2 * node_idx + 2]);
        }
    }

    fn update(&mut self, node_idx: usize, start: usize, end: usize, idx: usize, val: char) {
        if start == end {
            self.s_chars[idx] = val;
            self.tree[node_idx] = Node::new_leaf(val);
        } else {
            let mid = start + (end - start) / 2;
            if start <= idx && idx <= mid {
                self.update(2 * node_idx + 1, start, mid, idx, val);
            } else {
                self.update(2 * node_idx + 2, mid + 1, end, idx, val);
            }
            self.tree[node_idx] = Node::merge(&self.tree[2 * node_idx + 1], &self.tree[2 * node_idx + 2]);
        }
    }

    fn query_max_len(&self) -> i32 {
        self.tree[0].max_len as i32
    }
}

impl Solution {
    pub fn longest_repeating_substring(s: String, query_characters: Vec<char>, query_indices: Vec<i32>) -> Vec<i32> {
        let mut segment_tree = SegmentTree::new(s);
        let mut results = Vec::new();

        for i in 0..query_characters.len() {
            let idx = query_indices[i] as usize;
            let char_val = query_characters[i];
            segment_tree.update(0, 0, segment_tree.n - 1, idx, char_val);
            results.push(segment_tree.query_max_len());
        }

        results
    }
}