impl Solution {
    pub fn recover_array(n: usize, sums: Vec<i32>) -> Vec<i32> {
        let mut sums = sums;
        sums.sort();
        let half = sums.len() / 2;
        let total_sum: i32 = sums[0];
        let mut result = Vec::new();

        for diff in 1..=total_sum {
            let mut seen = std::collections::HashSet::new();
            let mut temp = Vec::new();
            let mut valid = true;

            for &sum in &sums {
                if seen.contains(&(sum - diff)) {
                    seen.remove(&(sum - diff));
                } else {
                    seen.insert(sum);
                    temp.push(sum + diff);
                }
            }

            if seen.is_empty() && temp.len() == half {
                result = temp;
                break;
            }
        }

        result
    }
}