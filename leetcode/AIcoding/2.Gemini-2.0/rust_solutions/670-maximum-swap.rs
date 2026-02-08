impl Solution {
    pub fn maximum_swap(num: i32) -> i32 {
        let mut s = num.to_string().chars().collect::<Vec<_>>();
        let n = s.len();
        let mut max_idx = n - 1;
        let mut idx1 = -1;
        let mut idx2 = -1;
        for i in (0..n - 1).rev() {
            if s[i] > s[max_idx] {
                max_idx = i;
            } else if s[i] < s[max_idx] {
                idx1 = i as i32;
                idx2 = max_idx as i32;
            }
        }
        if idx1 == -1 {
            return num;
        }
        s.swap(idx1 as usize, idx2 as usize);
        s.iter().collect::<String>().parse::<i32>().unwrap()
    }
}