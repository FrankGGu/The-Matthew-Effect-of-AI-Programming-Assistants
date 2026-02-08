const MOD: i64 = 1_000_000_007;

struct Fancy {
    seq: Vec<i64>,
    add: i64,
    mul: i64,
}

impl Fancy {
    fn new() -> Self {
        Fancy {
            seq: Vec::new(),
            add: 0,
            mul: 1,
        }
    }

    fn append(&mut self, val: i32) {
        let val = val as i64;
        let adjusted_val = (val - self.add + MOD) % MOD;
        let adjusted_val = adjusted_val * mod_inverse(self.mul, MOD) % MOD;
        self.seq.push(adjusted_val);
    }

    fn add_all(&mut self, inc: i32) {
        self.add = (self.add + inc as i64) % MOD;
    }

    fn mult_all(&mut self, m: i32) {
        let m = m as i64;
        self.add = (self.add * m) % MOD;
        self.mul = (self.mul * m) % MOD;
    }

    fn get_index(&self, idx: i32) -> i32 {
        if idx as usize >= self.seq.len() {
            -1
        } else {
            let val = (self.seq[idx as usize] * self.mul % MOD + self.add) % MOD;
            val as i32
        }
    }
}

fn mod_inverse(a: i64, m: i64) -> i64 {
    let mut a = a;
    let mut m = m;
    let mut y = 0;
    let mut x = 1;
    let mut m0 = m;

    if m == 1 {
        return 0;
    }

    while a > 1 {
        let q = a / m;
        let mut t = m;
        m = a % m;
        a = t;
        t = y;
        y = x - q * y;
        x = t;
    }

    if x < 0 {
        x += m0;
    }

    x
}