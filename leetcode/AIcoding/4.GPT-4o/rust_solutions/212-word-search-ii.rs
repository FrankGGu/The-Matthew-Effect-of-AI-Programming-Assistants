use std::collections::HashSet;

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    is_end: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: Default::default(),
            is_end: false,
        }
    }
}

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie { root: TrieNode::new() }
    }

    fn insert(&mut self, word: &str) {
        let mut node = &mut self.root;
        for ch in word.chars() {
            let index = (ch as usize) - ('a' as usize);
            node = node.children[index].get_or_insert_with(|| Box::new(TrieNode::new()));
        }
        node.is_end = true;
    }
}

struct Solution;

impl Solution {
    pub fn find_words(board: Vec<Vec<char>>, words: Vec<String>) -> Vec<String> {
        let mut trie = Trie::new();
        for word in &words {
            trie.insert(word);
        }

        let mut result = HashSet::new();
        let mut visited = vec![vec![false; board[0].len()]; board.len()];
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        fn backtrack(
            board: &Vec<Vec<char>>,
            node: &TrieNode,
            visited: &mut Vec<Vec<bool>>,
            path: &mut String,
            x: isize,
            y: isize,
            result: &mut HashSet<String>,
            directions: &Vec<(isize, isize)>
        ) {
            if node.is_end {
                result.insert(path.clone());
            }

            if x < 0 || x >= board.len() as isize || y < 0 || y >= board[0].len() as isize || visited[x as usize][y as usize] {
                return;
            }

            visited[x as usize][y as usize] = true;
            let index = (board[x as usize][y as usize] as usize) - ('a' as usize);
            if let Some(next_node) = &node.children[index] {
                path.push(board[x as usize][y as usize]);
                for (dx, dy) in directions.iter() {
                    backtrack(board, next_node, visited, path, x + dx, y + dy, result, directions);
                }
                path.pop();
            }
            visited[x as usize][y as usize] = false;
        }

        for i in 0..board.len() {
            for j in 0..board[0].len() {
                let index = (board[i][j] as usize) - ('a' as usize);
                if let Some(node) = &trie.root.children[index] {
                    let mut path = String::new();
                    backtrack(&board, node, &mut visited, &mut path, i as isize, j as isize, &mut result, &directions);
                }
            }
        }

        result.into_iter().collect()
    }
}