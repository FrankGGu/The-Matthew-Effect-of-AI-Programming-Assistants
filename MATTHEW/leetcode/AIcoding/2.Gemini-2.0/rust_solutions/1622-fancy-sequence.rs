const MOD: i64 = 1_000_000_007;

struct Fancy {
    seq: Vec<i64>,
    mul: i64,
    add: i64,
}

impl Fancy {
    fn new() -> Self {
        Fancy {
            seq: Vec::new(),
            mul: 1,
            add: 0,
        }
    }

    fn append(&mut self, val: i32) {
        let v = (val as i64 - self.add + MOD) % MOD * self.pow_mod(self.mul, MOD - 2) % MOD;
        self.seq.push(v);
    }

    fn add_all(&mut self, inc: i32) {
        self.add = (self.add + inc as i64) % MOD;
    }

    fn mult_all(&mut self, m: i32) {
        self.mul = (self.mul * m as i64) % MOD;
        self.add = (self.add * m as i64) % MOD;
    }

    fn get_index(&self, idx: i32) -> i32 {
        if idx as usize >= self.seq.len() {
            return -1;
        }
        let v = (self.seq[idx as usize] * self.mul % MOD + self.add) % MOD;
        v as i32
    }

    fn pow_mod(&self, base: i64, exp: i64) -> i64 {
        let mut res = 1;
        let mut b = base % MOD;
        let mut e = exp;
        while e > 0 {
            if e % 2 == 1 {
                res = (res * b) % MOD;
            }
            b = (b * b) % MOD;
            e /= 2;
        }
        res
    }
}