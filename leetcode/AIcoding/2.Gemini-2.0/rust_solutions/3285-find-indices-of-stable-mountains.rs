impl Solution {
    pub fn find_indices(mountain: Vec<i32>) -> Vec<i32> {
        let n = mountain.len();
        let mut ans = vec![-1, -1];

        for i in 1..n - 1 {
            if mountain[i] > mountain[i - 1] && mountain[i] > mountain[i + 1] {
                let mut l = i - 1;
                while l > 0 && mountain[l] > mountain[l - 1] {
                    l -= 1;
                }

                let mut r = i + 1;
                while r < n - 1 && mountain[r] > mountain[r + 1] {
                    r += 1;
                }

                if r - l + 1 >= 3 {
                    ans = vec![l as i32, r as i32];
                    break;
                }
            }
        }

        ans
    }
}