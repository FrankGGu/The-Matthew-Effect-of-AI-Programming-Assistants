use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn cat_mouse_game(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut color = HashMap::new();
        let mut degree = HashMap::new();
        let mut queue = VecDeque::new();

        for mouse in 0..n {
            for cat in 0..n {
                for turn in 0..2 {
                    let key = (mouse, cat, turn + 1);
                    if mouse == 0 {
                        color.insert(key, 1);
                        queue.push_back(key);
                    } else if cat == mouse {
                        color.insert(key, 2);
                        queue.push_back(key);
                    } else {
                        let degree_val = if turn == 0 {
                            graph[mouse].len()
                        } else {
                            graph[cat].len() - graph[cat].iter().filter(|&&x| x == 0).count()
                        };
                        degree.insert(key, degree_val);
                    }
                }
            }
        }

        while let Some((mouse, cat, turn)) = queue.pop_front() {
            let current_color = *color.get(&(mouse, cat, turn)).unwrap();
            for &parent in Self::get_parents(mouse, cat, turn, &graph) {
                if !color.contains_key(&parent) {
                    let (parent_mouse, parent_cat, parent_turn) = parent;
                    if (parent_turn == 1 && current_color == 1) || (parent_turn == 2 && current_color == 2) {
                        color.insert(parent, current_color);
                        queue.push_back(parent);
                    } else {
                        let degree_entry = degree.entry(parent).or_insert(0);
                        *degree_entry -= 1;
                        if *degree_entry == 0 {
                            let lose_color = if parent_turn == 1 { 2 } else { 1 };
                            color.insert(parent, lose_color);
                            queue.push_back(parent);
                        }
                    }
                }
            }
        }

        *color.get(&(1, 2, 1)).unwrap_or(&0)
    }

    fn get_parents(mouse: usize, cat: usize, turn: i32, graph: &[Vec<i32>]) -> Vec<(usize, usize, i32)> {
        let mut parents = Vec::new();
        let prev_turn = 3 - turn;
        if prev_turn == 1 {
            for &prev_cat in &graph[cat] {
                let prev_cat = prev_cat as usize;
                if prev_cat != 0 {
                    parents.push((mouse, prev_cat, prev_turn));
                }
            }
        } else {
            for &prev_mouse in &graph[mouse] {
                let prev_mouse = prev_mouse as usize;
                parents.push((prev_mouse, cat, prev_turn));
            }
        }
        parents
    }
}