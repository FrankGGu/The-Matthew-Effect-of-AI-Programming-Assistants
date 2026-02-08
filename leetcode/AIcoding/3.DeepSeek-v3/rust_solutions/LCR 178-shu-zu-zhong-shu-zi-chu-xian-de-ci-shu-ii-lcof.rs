impl Solution {
    pub fn training_plan(mut skills: Vec<i32>) -> Vec<i32> {
        let n = skills.len();
        let mut res = vec![0; n];
        let mut product = 1;

        for i in 0..n {
            res[i] = product;
            product *= skills[i];
        }

        product = 1;
        for i in (0..n).rev() {
            res[i] *= product;
            product *= skills[i];
        }

        res
    }
}