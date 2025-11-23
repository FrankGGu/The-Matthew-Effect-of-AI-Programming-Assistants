impl Solution {
    pub fn get_trigger_time(increase: Vec<Vec<i32>>, requirements: Vec<Vec<i32>>) -> Vec<i32> {
        let mut c = 0;
        let mut r = 0;
        let mut h = 0;
        let mut prefix = vec![(0, 0, 0)];
        for inc in increase {
            c += inc[0];
            r += inc[1];
            h += inc[2];
            prefix.push((c, r, h));
        }

        let mut res = Vec::new();
        for req in requirements {
            let (rc, rr, rh) = (req[0], req[1], req[2]);
            let mut left = 0;
            let mut right = prefix.len() as i32 - 1;
            let mut ans = -1;
            while left <= right {
                let mid = left + (right - left) / 2;
                let (mc, mr, mh) = prefix[mid as usize];
                if mc >= rc && mr >= rr && mh >= rh {
                    ans = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            res.push(ans);
        }
        res
    }
}