impl Solution {
    pub fn supply_wagon(supplies: Vec<i32>, k: i32) -> Vec<i32> {
        let mut supplies = supplies;
        let mut k = k;
        while k > 0 {
            let mut min_sum = i32::MAX;
            let mut min_index = 0;
            for i in 0..supplies.len() - 1 {
                let sum = supplies[i] + supplies[i + 1];
                if sum < min_sum {
                    min_sum = sum;
                    min_index = i;
                }
            }
            supplies[min_index] = supplies[min_index] + supplies[min_index + 1];
            supplies.remove(min_index + 1);
            k -= 1;
        }
        supplies
    }
}