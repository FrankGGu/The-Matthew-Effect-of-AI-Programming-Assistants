impl Solution {
    pub fn get_trigger_time(increase: Vec<Vec<i32>>, requirements: Vec<Vec<i32>>) -> Vec<i32> {
        let n = requirements.len();
        let mut ans = vec![-1; n];
        let mut c = 0;
        let mut r = 0;
        let mut h = 0;
        let mut o = 0;
        for i in 0..increase.len() {
            c += increase[i][0];
            r += increase[i][1];
            h += increase[i][2];
            for j in 0..n {
                if ans[j] == -1 && c >= requirements[j][0] && r >= requirements[j][1] && h >= requirements[j][2] {
                    ans[j] = (i + 1) as i32;
                }
            }
        }

        for j in 0..n {
             if ans[j] == -1 && 0 >= requirements[j][0] && 0 >= requirements[j][1] && 0 >= requirements[j][2] {
                ans[j] = 0;
            }
        }

        ans
    }
}