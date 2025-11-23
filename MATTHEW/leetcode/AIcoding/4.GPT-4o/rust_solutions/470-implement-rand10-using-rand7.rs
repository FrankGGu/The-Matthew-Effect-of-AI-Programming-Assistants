use rand::Rng;

struct Solution;

impl Solution {
    pub fn rand10() -> i32 {
        loop {
            let rand7_1 = Self::rand7();
            let rand7_2 = Self::rand7();
            let idx = (rand7_1 - 1) * 7 + rand7_2; // 1 to 49
            if idx <= 40 {
                return (idx - 1) % 10 + 1; // 1 to 10
            }
        }
    }

    fn rand7() -> i32 {
        let mut rng = rand::thread_rng();
        rng.gen_range(1..=7)
    }
}