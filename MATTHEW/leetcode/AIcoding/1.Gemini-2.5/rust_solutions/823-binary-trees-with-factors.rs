use std::collections::HashMap;

impl Solution {
    pub fn num_factored_binary_trees(mut arr: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;
        arr.sort_unstable();

        let mut dp: HashMap<i32, i64> = HashMap::new();

        for &num in arr.iter() {
            dp.insert(num, 1);

            for &factor1 in arr.iter() {
                if (factor1 as i64) * (factor1 as i64) > num as i64 {
                    break;
                }

                if num % factor1 == 0 {
                    let factor2 = num / factor1;

                    if dp.contains_key(&factor2) {
                        let count1 = *dp.get(&factor1).unwrap();
                        let count2 = *dp.get(&factor2).unwrap();

                        let current_trees = *dp.get(&num).unwrap();

                        if factor1 == factor2 {
                            dp.insert(num, (current_trees + (count1 * count2) % modulo) % modulo);
                        } else {
                            dp.insert(num, (current_trees + (count1 * count2 * 2) % modulo) % modulo);
                        }
                    }
                }
            }
        }

        let mut total_trees: i64 = 0;
        for &count in dp.values() {
            total_trees = (total_trees + count) % modulo;
        }

        total_trees as i32
    }
}