impl Solution {
    pub fn smallest_good_base(n: String) -> String {
        let n_val = n.parse::<u64>().unwrap();
        let mut ans = n_val - 1;
        let m = (n_val as f64).log2() as u64;

        for len in (2..=m + 1).rev() {
            let mut low: u64 = 2;
            let mut high: u64 = n_val - 1;

            while low <= high {
                let mid = low + (high - low) / 2;
                let mut sum: u64 = 1;
                let mut term: u64 = 1;
                let mut overflow = false;

                for _ in 1..len {
                    if n_val / mid < term {
                        overflow = true;
                        break;
                    }
                    term *= mid;
                    if n_val - sum < term {
                        overflow = true;
                        break;
                    }
                    sum += term;
                }

                if overflow || sum > n_val {
                    high = mid - 1;
                } else if sum < n_val {
                    low = mid + 1;
                } else {
                    ans = mid;
                    return ans.to_string();
                }
            }
        }

        ans.to_string()
    }
}