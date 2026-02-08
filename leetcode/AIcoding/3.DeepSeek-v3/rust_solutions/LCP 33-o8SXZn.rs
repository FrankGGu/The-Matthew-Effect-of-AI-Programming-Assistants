impl Solution {
    pub fn store_water(bucket: Vec<i32>, vat: Vec<i32>) -> i32 {
        let max_k = vat.iter().max().cloned().unwrap_or(0);
        if max_k == 0 {
            return 0;
        }
        let mut res = i32::MAX;
        for k in 1..=max_k {
            let mut cur = 0;
            for (&b, &v) in bucket.iter().zip(vat.iter()) {
                let least = (v + k - 1) / k;
                cur += std::cmp::max(0, least - b);
            }
            res = std::cmp::min(res, cur + k);
        }
        res
    }
}