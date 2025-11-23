use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn can_traverse_all_pairs(nums: Vec<i32>) -> bool {
        if nums.len() == 1 {
            return true;
        }
        let mut nums = nums;
        nums.sort();
        if nums[0] == 1 {
            return false;
        }

        let n = nums.len();
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut spf = Self::sieve(max_num);

        let mut parent: Vec<usize> = (0..=max_num).collect();
        let mut size: Vec<usize> = vec![1; max_num + 1];

        for &num in &nums {
            let mut x = num as usize;
            let mut factors = HashSet::new();
            while x > 1 {
                let p = spf[x];
                factors.insert(p);
                x /= p;
            }
            let factors: Vec<usize> = factors.into_iter().collect();
            for i in 0..factors.len() {
                Self::union(factors[0], factors[i], &mut parent, &mut size);
            }
        }

        let root = Self::find(nums[0] as usize, &mut parent);
        for &num in &nums {
            if Self::find(num as usize, &mut parent) != root {
                return false;
            }
        }
        true
    }

    fn sieve(n: usize) -> Vec<usize> {
        let mut spf = vec![0; n + 1];
        for i in 2..=n {
            if spf[i] == 0 {
                spf[i] = i;
                if i * i <= n {
                    let mut j = i * i;
                    while j <= n {
                        if spf[j] == 0 {
                            spf[j] = i;
                        }
                        j += i;
                    }
                }
            }
        }
        spf
    }

    fn find(mut x: usize, parent: &mut Vec<usize>) -> usize {
        while parent[x] != x {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        x
    }

    fn union(x: usize, y: usize, parent: &mut Vec<usize>, size: &mut Vec<usize>) {
        let x_root = Self::find(x, parent);
        let y_root = Self::find(y, parent);
        if x_root == y_root {
            return;
        }
        if size[x_root] < size[y_root] {
            parent[x_root] = y_root;
            size[y_root] += size[x_root];
        } else {
            parent[y_root] = x_root;
            size[x_root] += size[y_root];
        }
    }
}