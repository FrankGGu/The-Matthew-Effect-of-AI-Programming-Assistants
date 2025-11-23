struct Fancy {
    nums: Vec<i64>,
    add: Vec<i64>,
    mul: Vec<i64>,
    mod_val: i64,
}

impl Fancy {
    fn new() -> Self {
        Self {
            nums: Vec::new(),
            add: vec![0],
            mul: vec![1],
            mod_val: 1_000_000_007,
        }
    }

    fn append(&mut self, a: i32) {
        self.nums.push(a as i64);
        self.add.push(self.add[self.add.len() - 1]);
        self.mul.push(self.mul[self.mul.len() - 1]);
    }

    fn add_all(&mut self, inc: i32) {
        let inc = inc as i64;
        self.add[self.add.len() - 1] = (self.add[self.add.len() - 1] + inc) % self.mod_val;
    }

    fn multiply_all(&mut self, m: i32) {
        let m = m as i64;
        self.add.push((self.add[self.add.len() - 1] * m) % self.mod_val);
        self.mul.push((self.mul[self.mul.len() - 1] * m) % self.mod_val);
    }

    fn get_index(&self, i: i32) -> i32 {
        let i = i as usize;
        if i >= self.nums.len() {
            return -1;
        }
        let num = self.nums[i];
        let mul = self.mul[self.mul.len() - 1];
        let add = self.add[self.add.len() - 1];
        let result = (num * mul + add) % self.mod_val;
        result as i32
    }
}