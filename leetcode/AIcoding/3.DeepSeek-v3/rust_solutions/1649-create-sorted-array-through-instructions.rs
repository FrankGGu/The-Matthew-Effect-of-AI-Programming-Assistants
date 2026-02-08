struct FenwickTree {
    tree: Vec<i32>,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1],
        }
    }

    fn update(&mut self, mut index: usize, delta: i32) {
        while index < self.tree.len() {
            self.tree[index] += delta;
            index += index & (!index + 1);
        }
    }

    fn query(&self, mut index: usize) -> i32 {
        let mut res = 0;
        while index > 0 {
            res += self.tree[index];
            index -= index & (!index + 1);
        }
        res
    }
}

impl Solution {
    pub fn create_sorted_array(instructions: Vec<i32>) -> i32 {
        let max_val = *instructions.iter().max().unwrap() as usize;
        let mut fenwick = FenwickTree::new(max_val);
        let mut cost = 0;
        let modulo = 1_000_000_007;

        for (i, &num) in instructions.iter().enumerate() {
            let num = num as usize;
            let less = fenwick.query(num - 1);
            let greater = fenwick.query(max_val) - fenwick.query(num);
            cost = (cost + std::cmp::min(less, greater)) % modulo;
            fenwick.update(num, 1);
        }

        cost
    }
}