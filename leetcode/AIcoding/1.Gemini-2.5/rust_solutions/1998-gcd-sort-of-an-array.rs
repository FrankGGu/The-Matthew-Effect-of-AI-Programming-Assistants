use std::collections::HashMap;

struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            true
        } else {
            false
        }
    }
}

const MAX_VAL_LIMIT: usize = 100001;
static mut SPF: [i32; MAX_VAL_LIMIT] = [0; MAX_VAL_LIMIT];
static mut SIEVE_INITIALIZED: bool = false;

fn init_sieve() {
    unsafe {
        if SIEVE_INITIALIZED {
            return;
        }
        for i in 0..MAX_VAL_LIMIT {
            SPF[i] = i as i32;
        }
        for i in (2..).take_while(|&i| i * i < MAX_VAL_LIMIT) {
            if SPF[i] == i as i32 {
                for multiple in (i * i..MAX_VAL_LIMIT).step_by(i) {
                    if SPF[multiple] == multiple as i32 {
                        SPF[multiple] = i as i32;
                    }
                }
            }
        }
        SIEVE_INITIALIZED = true;
    }
}

fn get_prime_factors(mut n: i32) -> Vec<i32> {
    let mut factors = Vec::new();
    unsafe {
        while n > 1 {
            let p = SPF[n as usize];
            factors.push(p);
            while n % p == 0 {
                n /= p;
            }
        }
    }
    factors
}

impl Solution {
    pub fn gcd_sort(nums: Vec<i32>) -> bool {
        init_sieve();

        let n = nums.len();
        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();

        let mut uf = UnionFind::new(n);
        let mut prime_to_idx: HashMap<i32, usize> = HashMap::new();

        for i in 0..n {
            let num = nums[i];
            let factors = get_prime_factors(num);
            for p in factors {
                if let Some(&first_idx) = prime_to_idx.get(&p) {
                    uf.union(i, first_idx);
                } else {
                    prime_to_idx.insert(p, i);
                }
            }
        }

        let mut components_nums: HashMap<usize, Vec<i32>> = HashMap::new();
        let mut components_sorted_nums: HashMap<usize, Vec<i32>> = HashMap::new();

        for i in 0..n {
            let root = uf.find(i);
            components_nums.entry(root).or_default().push(nums[i]);
            components_sorted_nums.entry(root).or_default().push(sorted_nums[i]);
        }

        for (root, mut nums_list) in components_nums {
            let mut sorted_nums_list = components_sorted_nums.remove(&root).unwrap();
            nums_list.sort_unstable();
            sorted_nums_list.sort_unstable();
            if nums_list != sorted_nums_list {
                return false;
            }
        }

        true
    }
}