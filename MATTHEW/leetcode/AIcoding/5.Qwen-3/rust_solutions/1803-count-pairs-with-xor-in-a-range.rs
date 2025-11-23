impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(mut nums: Vec<i32>, mut lower: i32, mut upper: i32) -> i32 {
        let mut trie = Trie::new();
        let mut count = 0;

        for num in nums.iter() {
            count += trie.query(*num, lower, upper);
            trie.insert(*num);
        }

        count
    }
}

struct TrieNode {
    children: [Option<Box<TrieNode>>; 2],
}

struct Trie {
    root: Box<TrieNode>,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: Box::new(TrieNode {
                children: [None, None],
            }),
        }
    }

    fn insert(&mut self, num: i32) {
        let mut node = &mut self.root;
        for i in (0..31).rev() {
            let bit = (num >> i) & 1;
            if node.children[bit as usize].is_none() {
                node.children[bit as usize] = Some(Box::new(TrieNode {
                    children: [None, None],
                }));
            }
            node = node.children[bit as usize].as_mut().unwrap();
        }
    }

    fn query(&self, num: i32, lower: i32, upper: i32) -> i32 {
        let mut count = 0;
        let mut node = &self.root;
        let mut path = vec![];

        for i in (0..31).rev() {
            let bit = (num >> i) & 1;
            path.push(bit);
        }

        let mut stack = vec![(
            &self.root,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
        )];

        while let Some((
            node,
            idx,
            prefix,
            is_low,
            is_high,
            mask,
            low,
            high,
            l,
            r,
            a,
            b,
            c,
            d,
            e,
            f,
            g,
            h,
            i,
            j,
            k,
            m,
            n,
            o,
            p,
            q,
            s,
            t,
            u,
            v,
        )) = stack.pop()
        {
            if idx == 31 {
                if is_low && is_high {
                    count += 1;
                }
                continue;
            }

            let bit = (num >> (30 - idx)) & 1;
            let bit_to_check = (mask >> (30 - idx)) & 1;

            let mut next_nodes = vec![];

            for i in 0..2 {
                if let Some(child) = &node.children[i] {
                    let new_bit = i;
                    let new_is_low = is_low || (new_bit < bit);
                    let new_is_high = is_high || (new_bit > bit);

                    let new_mask = mask | ((new_bit ^ bit) << (30 - idx));
                    let new_low = low | ((new_bit ^ bit) << (30 - idx));
                    let new_high = high | ((new_bit ^ bit) << (30 - idx));

                    let new_l = l | ((new_bit ^ bit) << (30 - idx));
                    let new_r = r | ((new_bit ^ bit) << (30 - idx));

                    let new_a = a | ((new_bit ^ bit) << (30 - idx));
                    let new_b = b | ((new_bit ^ bit) << (30 - idx));
                    let new_c = c | ((new_bit ^ bit) << (30 - idx));
                    let new_d = d | ((new_bit ^ bit) << (30 - idx));
                    let new_e = e | ((new_bit ^ bit) << (30 - idx));
                    let new_f = f | ((new_bit ^ bit) << (30 - idx));
                    let new_g = g | ((new_bit ^ bit) << (30 - idx));
                    let new_h = h | ((new_bit ^ bit) << (30 - idx));
                    let new_i = i | ((new_bit ^ bit) << (30 - idx));
                    let new_j = j | ((new_bit ^ bit) << (30 - idx));
                    let new_k = k | ((new_bit ^ bit) << (30 - idx));
                    let new_m = m | ((new_bit ^ bit) << (30 - idx));
                    let new_n = n | ((new_bit ^ bit) << (30 - idx));
                    let new_o = o | ((new_bit ^ bit) << (30 - idx));
                    let new_p = p | ((new_bit ^ bit) << (30 - idx));
                    let new_q = q | ((new_bit ^ bit) << (30 - idx));
                    let new_s = s | ((new_bit ^ bit) << (30 - idx));
                    let new_t = t | ((new_bit ^ bit) << (30 - idx));
                    let new_u = u | ((new_bit ^ bit) << (30 - idx));
                    let new_v = v | ((new_bit ^ bit) << (30 - idx));

                    next_nodes.push((child, idx + 1, prefix, new_is_low, new_is_high, new_mask, new_low, new_high, new_l, new_r, new_a, new_b, new_c, new_d, new_e, new_f, new_g, new_h, new_i, new_j, new_k, new_m, new_n, new_o, new_p, new_q, new_s, new_t, new_u, new_v));
                }
            }

            for node in next_nodes.into_iter().rev() {
                stack.push(node);
            }
        }

        count
    }
}
}