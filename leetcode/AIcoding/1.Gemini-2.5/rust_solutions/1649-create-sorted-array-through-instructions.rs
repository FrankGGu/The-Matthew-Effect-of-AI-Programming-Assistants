struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(max_val: usize) -> Self {
        FenwickTree {
            tree: vec![0; max_val + 1],
            size: max_val,
        }
    }

    fn update(&mut self, mut idx: usize, val: i32) {
        while idx <= self.size {
            self.tree[idx] += val;
            idx += idx & (!idx + 1);
        }
    }

    fn query(&self, mut idx: usize) -> i32 {
        let mut sum = 0;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (!idx + 1);
        }
        sum
    }
}

impl Solution {
    pub fn create_sorted_array(instructions: Vec<i32>) -> i32 {
        let max_val = *instructions.iter().max().unwrap() as usize;

        let mut ft = FenwickTree::new(max_val);
        let mut total_cost: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for (i, &num) in instructions.iter().enumerate() {
            let num_usize = num as usize;

            let less_count = ft.query(num_usize - 1) as i64;
            let greater_count = (i as i64 - ft.query(num_usize) as i64);

            total_cost = (total_cost + less_count.min(greater_count)) % modulo;

            ft.update(num_usize, 1);
        }

        total_cost as i32
    }
}