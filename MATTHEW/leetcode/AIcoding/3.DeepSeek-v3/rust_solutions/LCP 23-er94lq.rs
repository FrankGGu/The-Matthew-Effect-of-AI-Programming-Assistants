impl Solution {
    pub fn is_magic(target: Vec<i32>) -> bool {
        let n = target.len();
        let mut k = 0;
        let mut perm: Vec<i32> = (1..=n as i32).collect();

        let mut step = 0;
        loop {
            let mut next_perm = Vec::new();
            for i in (1..perm.len()).step_by(2) {
                next_perm.push(perm[i]);
            }
            for i in (0..perm.len()).step_by(2) {
                next_perm.push(perm[i]);
            }
            if next_perm == target {
                return true;
            }
            if step == 0 {
                let mut i = 0;
                while i < n && next_perm[i] == target[i] {
                    i += 1;
                }
                k = i;
                if k == 0 {
                    return false;
                }
            } else {
                if k >= n {
                    return false;
                }
                let mut valid = true;
                for i in 0..k {
                    if i >= next_perm.len() || next_perm[i] != target[i] {
                        valid = false;
                        break;
                    }
                }
                if !valid {
                    return false;
                }
            }
            perm = next_perm[k..].to_vec();
            step += 1;
            if perm.is_empty() {
                break;
            }
        }
        false
    }
}