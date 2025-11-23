impl Solution {
    pub fn maximum_beauty(flowers: Vec<i32>, new_flowers: i64, target: i32, full: i32, partial: i32) -> i64 {
        let mut flowers = flowers;
        flowers.sort();
        let n = flowers.len();
        let target = target as i64;
        let full = full as i64;
        let partial = partial as i64;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + flowers[i] as i64;
        }

        let mut res = 0;
        let mut j = n;
        for i in (0..=n).rev() {
            if i < n {
                let needed = target - flowers[i] as i64;
                if new_flowers < needed {
                    break;
                }
                flowers[i] = target as i32;
            }
            let mut remaining = new_flowers;
            if i < n {
                remaining -= needed;
            }
            while j > i {
                j -= 1;
            }
            while j > 0 && (flowers[j - 1] as i64) < target && remaining > 0 {
                let m = j;
                let current = flowers[m - 1] as i64;
                let next = if m < i { flowers[m] as i64 } else { target };
                let max_add = next - current;
                let total = prefix[m] as i64;
                let max_possible = current * m as i64 - total;
                let add = std::cmp::min(max_add * m as i64, remaining);
                remaining -= add;
                let min_val = current + add / m as i64;
                if min_val < target {
                    res = std::cmp::max(res, full * (n - i) as i64 + partial * min_val);
                }
                if add < max_add * m as i64 {
                    break;
                }
                j -= 1;
            }
            if j == 0 {
                break;
            }
            if flowers[j - 1] as i64 >= target {
                continue;
            }
            let m = j;
            let total = prefix[m] as i64;
            let min_val = std::cmp::min(target - 1, (total + remaining) / m as i64);
            if min_val > 0 {
                res = std::cmp::max(res, full * (n - i) as i64 + partial * min_val);
            }
        }
        res
    }
}