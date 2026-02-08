impl Solution {
    pub fn supply_wagon(mut supplies: Vec<i32>) -> Vec<i32> {
        let n = supplies.len();
        let target = n / 2;
        while supplies.len() > target {
            let mut min_sum = i32::MAX;
            let mut merge_pos = 0;
            for i in 0..supplies.len() - 1 {
                let sum = supplies[i] + supplies[i + 1];
                if sum < min_sum {
                    min_sum = sum;
                    merge_pos = i;
                }
            }
            supplies[merge_pos] += supplies[merge_pos + 1];
            supplies.remove(merge_pos + 1);
        }
        supplies
    }
}