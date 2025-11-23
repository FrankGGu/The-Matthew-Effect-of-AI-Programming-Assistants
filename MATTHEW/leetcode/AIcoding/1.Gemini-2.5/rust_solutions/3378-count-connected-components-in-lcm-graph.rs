use std::collections::HashMap;

struct UnionFind {
    parent: Vec<usize>,
    count: usize,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            count: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_i] = root_j;
            self.count -= 1;
            true
        } else {
            false
        }
    }
}

const MAX_VAL: usize = 100001; 
static mut SPF: [i32; MAX_VAL] = [0; MAX_VAL];
static mut SPF_INITIALIZED: bool = false;

fn init_spf_sieve() {
    unsafe {
        if SPF_INITIALIZED {
            return;
        }
        for i in 0..MAX_VAL {
            SPF[i] = i as i32;
        }
        for i in (2..MAX_VAL).step_by(2) {
            SPF[i] = 2;
        }
        for i in (3..MAX_VAL).step_by(2) {
            if SPF[i] == i as i32 { 
                for j in (i * i..MAX_VAL).step_by(i) {
                    if SPF[j] == j as i32 { 
                        SPF[j] = i as i32;
                    }
                }
            }
        }
        SPF_INITIALIZED = true;
    }
}

fn get_prime_factors_sieve(mut n: i32) -> Vec<i32> {
    let mut factors = Vec::new();
    unsafe {
        while n > 1 {
            let p = SPF[n as usize];
            factors.push(p);
            while n > 1 && n % p == 0 { // Ensure n > 1 before division to avoid infinite loop if n becomes 0 or 1
                n /= p;
            }
        }
    }
    factors
}

impl Solution {
    pub fn count_components(nums: Vec<i32>) -> i32 {
        init_spf_sieve();

        let n = nums.len();
        let mut uf = UnionFind::new(n);
        let mut prime_to_index: HashMap<i32, usize> = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            let factors = get_prime_factors_sieve(num);
            for p in factors {
                if let Some(&first_idx) = prime_to_index.get(&p) {
                    uf.union(i, first_idx);
                } else {
                    prime_to_index.insert(p, i);
                }
            }
        }

        uf.count as i32
    }
}