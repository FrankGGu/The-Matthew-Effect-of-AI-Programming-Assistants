struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1],
            size,
        }
    }

    fn update(&mut self, mut index: usize, val: i32) {
        index += 1;
        while index <= self.size {
            self.tree[index] += val;
            index += index & index.wrapping_neg();
        }
    }

    fn query(&self, mut index: usize) -> i32 {
        index += 1;
        let mut sum = 0;
        while index > 0 {
            sum += self.tree[index];
            index -= index & index.wrapping_neg();
        }
        sum
    }
}

impl Solution {
    pub fn distribute_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();

        let mut sorted_unique_nums = nums.clone();
        sorted_unique_nums.sort_unstable();
        sorted_unique_nums.dedup();

        let val_to_idx: std::collections::HashMap<i32, usize> = sorted_unique_nums
            .into_iter()
            .enumerate()
            .map(|(i, val)| (val, i))
            .collect();

        let k = val_to_idx.len();

        let mut arr1 = Vec::new();
        let mut arr2 = Vec::new();

        let mut ft1 = FenwickTree::new(k);
        let mut ft2 = FenwickTree::new(k);

        arr1.push(nums[0]);
        ft1.update(*val_to_idx.get(&nums[0]).unwrap(), 1);

        arr2.push(nums[1]);
        ft2.update(*val_to_idx.get(&nums[1]).unwrap(), 1);

        for i in 2..n {
            let num = nums[i];
            let compressed_idx = *val_to_idx.get(&num).unwrap();

            let cnt1 = ft1.query(k - 1) - ft1.query(compressed_idx);
            let cnt2 = ft2.query(k - 1) - ft2.query(compressed_idx);

            if cnt1 > cnt2 {
                arr1.push(num);
                ft1.update(compressed_idx, 1);
            } else if cnt2 > cnt1 {
                arr2.push(num);
                ft2.update(compressed_idx, 1);
            } else {
                arr1.push(num);
                ft1.update(compressed_idx, 1);
            }
        }

        arr1.extend(arr2);
        arr1
    }
}