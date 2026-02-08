impl Solution {
    pub fn recover_array(n: i32, sums: Vec<i32>) -> Vec<i32> {
        let mut sums = sums;
        sums.sort_unstable();
        let mut res = Vec::new();
        let mut current = Vec::new();
        Self::dfs(&sums, &mut res, &mut current, n as usize);
        res
    }

    fn dfs(sums: &[i32], res: &mut Vec<i32>, current: &mut Vec<i32>, n: usize) -> bool {
        if sums.len() == 1 {
            if sums[0] == 0 {
                return true;
            } else {
                return false;
            }
        }
        let x = sums[1] - sums[0];
        let mut left = Vec::new();
        let mut right = Vec::new();
        let mut freq = std::collections::HashMap::new();
        for &num in sums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut valid = true;
        for &num in sums {
            if *freq.get(&num).unwrap_or(&0) == 0 {
                continue;
            }
            if *freq.get(&(num + x)).unwrap_or(&0) == 0 {
                valid = false;
                break;
            }
            *freq.get_mut(&num).unwrap() -= 1;
            *freq.get_mut(&(num + x)).unwrap() -= 1;
            left.push(num);
            right.push(num + x);
        }
        if valid {
            current.push(x);
            if Self::dfs(&left, res, current, n) && current.len() == n {
                *res = current.clone();
                return true;
            }
            current.pop();
        }
        current.push(-x);
        if Self::dfs(&right, res, current, n) && current.len() == n {
            *res = current.clone();
            return true;
        }
        current.pop();
        false
    }
}