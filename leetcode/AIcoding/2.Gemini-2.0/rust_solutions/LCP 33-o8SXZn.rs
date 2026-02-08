impl Solution {
    pub fn store_water(bucket: Vec<i32>, vat: Vec<i32>) -> i32 {
        let n = bucket.len();
        let mut max_vat = 0;
        for i in 0..n {
            max_vat = max_vat.max(vat[i]);
        }

        if max_vat == 0 {
            return 0;
        }

        let mut ans = i32::MAX;
        for k in 1..=max_vat {
            let mut ops = k;
            for i in 0..n {
                let need = (vat[i] as f64 / k as f64).ceil() as i32;
                ops += (0.max(need - bucket[i]));
            }
            ans = ans.min(ops);
        }
        ans
    }
}