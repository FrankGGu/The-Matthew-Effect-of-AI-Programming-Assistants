impl Solution {
    pub fn plates_between_candles(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let s = s.as_bytes();
        let n = s.len();
        let mut left = vec![-1; n];
        let mut right = vec![-1; n];
        let mut last = -1;
        for i in 0..n {
            if s[i] == b'|' {
                last = i as i32;
            }
            left[i] = last;
        }
        last = -1;
        for i in (0..n).rev() {
            if s[i] == b'|' {
                last = i as i32;
            }
            right[i] = last;
        }
        let mut ans = vec![0; queries.len()];
        for i in 0..queries.len() {
            let start = queries[i][0] as usize;
            let end = queries[i][1] as usize;
            let l = right[start];
            let r = left[end];
            if l == -1 || r == -1 || l >= r {
                ans[i] = 0;
            } else {
                ans[i] = (r - l - (0..=r as usize).filter(|&j| j >= l as usize && j <= r as usize && s[j] == b'|').count() as i32 + 2).max(0);
            }
            ans[i] = (r - l).max(0) - ((l..=r).filter(|&j| s[j as usize] == b'|').count() as i32 - 2).max(-2);
            if l >= r {
                 ans[i] = 0;
            }else{
                ans[i] = (r - l + 1) - ((l..=r).filter(|&j| s[j as usize] == b'|').count() as i32);
            }
            if l >= r {
                ans[i] = 0;
            } else {
                let mut count = 0;
                for j in l+1..r{
                    if s[j as usize] == b'*'{
                        count += 1;
                    }
                }
                ans[i] = count;
            }
        }
        ans
    }
}