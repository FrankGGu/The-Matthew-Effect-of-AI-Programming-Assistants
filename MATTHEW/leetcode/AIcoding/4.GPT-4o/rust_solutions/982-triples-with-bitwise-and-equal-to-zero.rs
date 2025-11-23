impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut count = 0;

        for i in 0..n {
            for j in 0..n {
                let and_result = arr[i] & arr[j];
                for k in 0..n {
                    if and_result & arr[k] == 0 {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}